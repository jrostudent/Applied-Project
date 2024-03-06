#!/bin/bash

#SBATCH -N 1  # number of nodes
#SBATCH -c 2  # number of cores to allocate
#SBATCH --mem=30G # memory allocation
#SBATCH -t 0-03:00:00   # time in d-hh:mm:ss
#SBATCH -p general       # partition
#SBATCH -q public       # QOS
#SBATCH -o /scratch/jrosen5/applied_proj/sandbox/srmoputs/slurm.%j.out # file to save job's STDOUT (%j = JobId)
#SBATCH -e /scratch/jrosen5/applied_proj/sandbox/srmoputs/slurm.%j.err # file to save job's STDERR (%j = JobId)
#SBATCH --export=NONE   # Purge the job-submitting shell environment


#change to your desired dir
cd /yourdir/here/sandbox

#initialize fastp environment through mamba
module load mamba/latest

source activate fastp

# Loop over paired-end files in PDreads directory
for read1in in /your/PDdir/here/PDreads/*_1.fastq.gz; do

    # Get corresponding read2 file
    read2in="${read1in%_1.fastq.gz}_2.fastq.gz"
    base_name=$(basename "$read1in" "_1.fastq.gz")

    read1out="/scratch/jrosen5/applied_proj/sandbox/data/kmerMatrix/${base_name}_fastpPE1"
    read2out="/scratch/jrosen5/applied_proj/sandbox/data/kmerMatrix/${base_name}_fastpPE2"
    mergeReadout="/scratch/jrosen5/applied_proj/sandbox/data/kmerMatrix/${base_name}_fastp.fq"
    histoTXT="/scratch/jrosen5/applied_proj/sandbox/data/kmerMatrix/${base_name}_histoPE.txt"
    Matrixcsv="/scratch/jrosen5/applied_proj/sandbox/data/kmerMatrix/PDmatrix2/${base_name}_Matrix.csv"

    # Check if CSV matrix already exists and skip if it does
    if [[ -f "$Matrixcsv" ]]; then
        echo "CSV matrix for $base_name already exists. Skipping..."
        continue
    fi

    # fastp command for fasterq output
    fastp -i "$read1in" -I "$read2in" -o "$read1out" -O "$read2out" -m --merged_out "$mergeReadout" --correction --include_unmerged 

    # sed command to delete merged__ string in seq header and deleting space before merged
    sed -i 's/ merged_[0-9]*_[0-9]*//g' "$mergeReadout"

    OLDLIB=$LD_LIBRARY_PATH
    OLDINC=$INCLUDE
    OLDBIN=$PATH
    #path adjustments due to unique path issues on HPC system
    #made in consultation with RC staff
    export PATH="/yourpath/here:$PATH"
    export INCLUDE="/home/yourpath/here/include:$INCLUDE"
    export LD_LIBRARY_PATH="/home/yourpath/here/bin:$LD_LIBRARY_PATH"

    # 27mers, strict memory mode, using SRR fastq file, histogram kmc
    kmc -k27 -ci25 "$mergeReadout" histogram . 

    # transform KMC output into txt file
    kmc_tools transform histogram dump "$histoTXT"

    export PATH="$OLDBIN"
    export INCLUDE="$OLDINC"
    export LD_LIBRARY_PATH="$OLDLIB"

    # turn .txt file into CSV consisting of two columns (kmer seq column & sample runID + response value in count column)
    #(echo "kmer,count" && awk -F'\t' 'NR>1 {print $1 "," $2}' "$histoTXT") >> "$Matrixcsv"

     {
    echo "kmer,${base_name}_NR"
    awk -F'\t' 'NR>1 {print $1 "," $2}' "$histoTXT"
} >> "$Matrixcsv"

    #print line count and size of intermediate files
    wc -l "$mergeReadout"
    du -h "$mergeReadout"
    stat "$mergeReadout"
    # removing intermediate files
    rm /yourdir/here/sandbox/histogram.kmc_pre /yourdir/here/sandbox/histogram.kmc_suf
    rm "$mergeReadout" 
    rm "$histoTXT"
    
    echo "$Matrixcsv Created"
done


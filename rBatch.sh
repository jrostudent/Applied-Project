#!/bin/bash

#SBATCH -N 1
#SBATCH -c 16  # number of cores to allocate
#SBATCH -p highmem
#SBATCH -q public
#SBATCH -t 1-0
#SBATCH -n 1
#SBATCH --mem=700G
#SBATCH --export=NONE
#SBATCH -o /home/jrosen5/applied_proj/sandbox/slurmOutputs/slurm.%j.out # file to save job's STDOUT (%j = JobId)
#SBATCH -e /home/jrosen5/applied_proj/sandbox/slurmOutputs/slurm.%j.err # file to save job's STDERR (%j = JobId)

module load r-4.2.2-gcc-11.2.0

cd /home/jrosen5/applied_proj/sandbox/Rscripts

Rscript nestedcv_script_final.R

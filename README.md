# Applied Project
This repository hosts my master's degree applied project for the ASU Bio Data Science program. Below is information about the files included in this repository:

# SRA Data Downloader Notebook

This Jupyter notebook provides an automated approach to download SRA (Sequence Read Archive) data files, specifically designed for handling large datasets and avoiding redundancy. It streamlines the downloading process for paired-end read files and organizes them efficiently for further analysis.

## Features

- **Data Extraction**: Extracts SRA run IDs from a specified CSV file to prepare a list of files to be downloaded.
- **Duplication Check**: Before initiating a download, the script checks if the file already exists in the target directory, preventing unnecessary re-downloading.
- **Automated Downloading**: Utilizes the `prefetch` command from the SRA toolkit to download SRA files.
- **Fastq Conversion**: Converts SRA files to compressed fastq format using `fastq-dump`, enabling compatibility with various bioinformatics analysis tools.
- **Logging**: Outputs the download and conversion process details, providing transparency and traceability.

## Workflow

1. **Initialization**: Loads necessary Python modules and defines the directory paths for storing the downloaded data.
2. **Run ID Extraction**: Reads a CSV file to extract SRA run IDs and stores them in a list for processing.
3. **Data Downloading and Conversion**: For each SRA ID:
   - Checks if the SRA file or its corresponding fastq file already exists.
   - If not present, downloads the SRA file using `prefetch` and converts it to fastq format with `fastq-dump`.
   - Outputs the process details, including any skipping of existing files.

## Usage

- Ensure the CSV file with SRA run IDs is correctly formatted and accessible.
- Specify the correct paths for the input CSV file, the download directory, and the output directory for fastq files.
- Execute the notebook cells sequentially to initiate the downloading and conversion process.

This notebook is a practical tool for researchers needing to download and prepare large sets of SRA data for genomic or metagenomic analysis.


## Full Join Loop (K-mer Matrix Aggregator Script)

This Python script automates the process of aggregating k-mer matrices by performing a full join on multiple CSV files containing k-mer rows and sample columns. It is particularly useful for compiling comprehensive k-mer datasets from various samples, facilitating downstream bioinformatics analysis.

## Features

- **Dynamic File Processing**: Iterates through directories containing CSV files to aggregate data based on k-mers.
- **Full Join Operation**: Utilizes a full join to merge matrices, ensuring all k-mers are included in the final aggregated matrix.
- **NA Handling**: Converts any NA values resulting from the join to 0, maintaining a consistent data format.
- **Output Generation**: Produces a comprehensive CSV file containing the aggregated k-mer matrix.

## Workflow

1. **Directory Specification**: Set the paths to the directories containing the CSV files to be aggregated.
2. **Data Aggregation**: For each CSV file in the specified directories:
   - Extracts the file's base name to identify the sample.
   - Reads the k-mer data and merges it with the accumulating DataFrame, ensuring all k-mers across samples are represented.
3. **NA Value Replacement**: Post-merge, replaces any NA values with 0 to maintain data integrity.
4. **Output**: The final aggregated matrix is saved as a CSV file, with details printed regarding the number of rows and columns.

## Usage

- Update the `PD_path` and `PRCR_path` variables to point to the directories containing your CSV files.
- Ensure the CSV files are formatted correctly, with k-mer rows and sample columns.
- Modify the output path in the script to where you want the aggregated matrix CSV file to be saved.
- Run the script in a Python environment with the necessary dependencies installed.

This script is a valuable tool for bioinformaticians looking to compile k-mer data from various samples into a single, comprehensive dataset for further analysis.


## Inner Join Loop
This script functions like the Full Join Loop but is set to perform an inner join operation. It is designed to iterate through directories containing kmer matrices, joining them based on sample type and exporting the combined matrix to a CSV file.

# K-mer Matrix Generation Script (protoprojBash.sh) 

This Bash script automates the processing of paired-end read files for k-mer analysis in a high-performance computing (HPC) environment. It uses SLURM directives to allocate resources for the job, including nodes, cores, memory, and execution time. This is one of the most critical parts of my project pipeline

## Key Features

- **Resource Allocation**: Utilizes SLURM for specifying job resources like nodes, cores, memory, and time.
- **Automated Processing**: Iterates over paired-end read files to perform quality control, preprocessing, k-mer counting, and output formatting.
- **Environment Management**: Manages software environments and paths specific to the HPC system for consistent and error-free execution.

## Process Workflow

1. **Environment Setup**: Changes the working directory and activates a `fastp` environment using Mamba for read preprocessing.
2. **File Processing**: For each pair of read files, the script:
    - Checks for existing output to avoid redundant processing.
    - Runs `fastp` for read quality control and preprocessing.
    - Formats sequence headers for compatibility with downstream tools.
    - Adjusts environment paths to accommodate HPC system specifics.
    - Executes `kmc` and `kmc_tools` to generate and format k-mer counts.
    - Transforms k-mer count data into a CSV matrix for downstream analysis.
    - Logs the line count and size of intermediate files.
    - Cleans up intermediate files to save space.
3. **Output**: Produces a CSV file for each input file pair, containing k-mer sequences and their corresponding counts.

## Usage

This script is tailored for bioinformatics workflows requiring efficient k-mer analysis of sequencing data. It's part of a larger pipeline that facilitates comprehensive transcriptomic analysis.

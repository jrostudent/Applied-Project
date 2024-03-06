# Applied Project
This repository hosts my master's degree applied project for the ASU Bio Data Science program. Below is information about the files included in this repository:

## Dataset SRA Loader
This script iterates through a specified directory to load SRA files based on run IDs stored in a CSV file. It requires the SRA toolkit to be installed and configured beforehand. This script is a significant timesaver, as it allows for the bulk downloading of entire study sample datasets, rather than downloading each file individually. It also features functionality to avoid redundant downloads of the same file, which is particularly useful if a download session is interrupted and needs to be restarted. The notebook demonstrates its use for downloading two different types of samples (PD and PRCR) and efficiently sorting them into their respective destination directories.

## Full Join Loop
This script is similar to the Inner Join Loop but is configured for a full join operation. It iterates through a directory containing matrices with kmer rows and sample columns to full join them based on their sample type (e.g., PD for progressive disease). The script creates a kmer matrix, replaces NA values with 0, and outputs the result to a CSV file. While the script is dependent on file nomenclature, it can be easily adapted for different datasets.

## Inner Join Loop
This script functions like the Full Join Loop but is set to perform an inner join operation. It is designed to iterate through directories containing kmer matrices, joining them based on sample type and exporting the combined matrix to a CSV file.

# K-mer Matrix Generation Script

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

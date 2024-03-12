# Applied Project
This repository hosts my master's degree applied project for the ASU Bio Data Science program. Below is information about the files included in this repository:

# SRA Data Downloader Notebook (dsetSRAdloader.ipynb)

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


##K-mer Matrix Aggregator Script (full_join_loop_python.py)

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

# K-mer Count Data Normalization Script (VSTnormscript.R)

This R script is designed to perform normalization on k-mer count data using the Variance Stabilizing Transformation (VST) method from the DESeq2 library. It's particularly useful for preparing k-mer count data for downstream statistical analysis and comparisons.

## Features

- **Library Utilization**: Employs DESeq2 for normalization, readr for data input, and tidyverse for data manipulation.
- **VST Normalization**: Applies the variance stabilizing transformation to the count data to stabilize the variance across the range of counts.
- **Local Regression Fit**: Uses a local regression fit (`fitType = "local"`) to better capture the dispersion trend, which is crucial for datasets where the variance is not well modeled by a simple function.

## Workflow

1. **Data Input**: Reads a CSV file containing the k-mer count data into a matrix.
2. **Normalization**: Performs Variance Stabilizing Transformation on the k-mer count data matrix.
3. **Matrix Analysis**: Calculates and prints the dimensions of the resulting VST matrix along with the total number of k-mer counts.
4. **Output Generation**: Writes the normalized matrix back to a CSV file for subsequent use.

## Usage

- Update the path in `read.csv` to the location of your k-mer count data CSV file.
- Ensure that the CSV is formatted correctly, with rows representing k-mers and columns representing samples.
- Update the output file path in `write.csv` to where you want the normalized matrix to be saved.
- Execute the script in an R environment with the necessary libraries installed.

This script is essential for researchers working with k-mer count data, as it provides a robust method for normalization, facilitating more accurate downstream analysis.

# K-mer Count Matrix Classification ML Script (nestedcv_script_final.R)

This R script performs a comprehensive analysis on a k-mer count matrix, applying a nested cross-validation approach using the glmnet model for classification. The script is structured to handle large datasets, preprocess them, and apply a machine learning model to evaluate the predictive performance based on the provided metadata.

## Features

- **Data Preprocessing**: Loads and preprocesses the k-mer count matrix, including transposition and scaling, to prepare for analysis.
- **Metadata Alignment**: Ensures that the metadata is correctly aligned with the count data for accurate model training and evaluation.
- **Nested Cross-Validation**: Implements nested cross-validation using glmnet for model selection and evaluation, providing robust assessment of the model's performance.
- **Visualization**: Generates plots for alpha and lambda selection, as well as ROC curves, to visually represent model performance and parameter selection.

## Workflow

1. **Data Loading**: Imports the k-mer count matrix and associated metadata, replacing any NA values with 0 for consistency.
2. **Data Transformation**: Transposes and scales the count data to align with the metadata and normalize the feature scales.
3. **Model Training and Evaluation**:
   - Applies nested cross-validation using the glmnet model, optimizing parameters and evaluating the model's predictive performance.
   - Uses a t-test filter to select the most relevant features for the model, enhancing the predictive accuracy and efficiency.
4. **Result Visualization**:
   - Plots the selection process for alpha and lambda parameters, aiding in understanding the model's complexity and regularization.
   - Generates ROC curves for both inner and outer cross-validation folds to assess and visualize the model's discriminative ability.

## Usage

- Update the paths to the count matrix and metadata files as required.
- Configure the `nestcv.glmnet` parameters if different settings are needed for the analysis.
- Run the script in an R environment with the necessary libraries (`readr`, `tidyverse`, `nestedcv`) installed.

This script is ideal for bioinformaticians and data scientists looking to apply advanced machine learning techniques to genomic or metagenomic count data for classification purposes, providing insights into the data's underlying biological or medical attributes.

# High-Performance Computing R Script Execution (rBatch.sh)

This Bash script is designed to run an R script (`nestedcv_script_final.R`) on a High-Performance Computing (HPC) cluster using SLURM workload manager. It specifies the computational resources required and manages the execution environment for the R script, ensuring optimal performance for intensive computations.

## Features

- **Resource Allocation**: Requests a significant amount of resources (16 cores, 700G memory) to handle large-scale data analysis.
- **Environment Configuration**: Sets up the necessary module (R version 4.2.2) and changes to the appropriate directory to execute the R script.
- **Output Management**: Captures the standard output and standard error into specified files for troubleshooting and review post-execution.

## Workflow

1. **Job Specification**: Defines the job's resource requirements, including cores, memory, partition, quality of service, and time limit.
2. **Module Loading**: Loads the specified R module to ensure the script runs with the correct version and dependencies.
3. **Script Execution**: Executes the `nestedcv_script_final.R` script, which is expected to be a comprehensive R script possibly performing tasks such as data processing, statistical modeling, or machine learning.

## Usage

- Place the Bash script in the same directory as the `nestedcv_script_final.R` or adjust the `cd` command to the script's directory.
- Submit the script to the SLURM scheduler using `sbatch rBatch.sh`.
- Monitor the job's execution via SLURM commands (e.g., `squeue`, `sacct`) and check the output and error files for logs and potential issues.

This script is crucial for researchers or data scientists who need to run resource-intensive R scripts on an HPC environment, facilitating advanced data analysis, statistical modeling, or computational tasks that require substantial computational power.




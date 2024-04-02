# Applied Project
This repository hosts my master's degree applied project for the ASU Bio Data Science program. Below is information about the files included in this repository:

# SRA Data Downloader Notebook (dsetSRAdloader.ipynb)

This jupyter notebook provides an efficient and automated approach to downloading .fastq files from SRA. It is optimized for large datasets (with long download times) with features designed to avoid redundancies and ensure organization. 

## Workflow
- **Initialization**: Loads packages, defines dir paths for storing downloaded files
- **ID Extraction**: Reads .csv, extracts run IDs and stores them in list for data download
- **Data Download**: Checks if ID matching files already exist in SRA or .fastq dirs
   -if not; downloads using 'prefetch'
   -converts to .fastq using 'fastq-dump'
## Usage 
-Configure path to run ID .csv file 
-Configure download dirs for SRA & .fastq files

## Summary
A very useful script for efficiently downloading .fastq from SRA, allows for worry free downloads with large datasets & long download times

# K-mer Matrix Full Join loop (full_join_loop_python.py)
A python script designed to automate the full-joining of k-mer matrices (consisting of a k-mer sequence column and a count column) into a larger matrix consisting of k-mer rows and sample columns with count records. This can also be used for other forms of 'omic data, such as gene count matrices. 

## Workflow
- **Initialization**: Loads packages, defines dir paths
- **Join Loop**: Iterates through target directories, full joining files on the k-mer column 
- **Error checks, NA, Output**: Replaces NA values with zero, prints matrix dimensions for error check/documentation purposes, writes matrix to .csv file

## Usage
- Configure paths and ensure directories are exclusively filled with target files

# K-mer Matrix Bash Script (protoprojBash.sh)
A bash script designed to process paired-end .fastq files through the KMC and fastp portions of the project pipeline into a k-mer matrix output. It is designed for use in an HPC environment, and has preset SLURM settings as such. Can be used for other forms of 'omic data with some significant modications. 

## Workflow 
- **Initialization**:
   -Sets working dir 
   -loads fastp environment using mamba
   -sets slurm options
- **Processing**:
   -sets desired dir paths for variables 
   -iterates through directories, checks for file redundancy, continues if clear
   -fastp processing for paried end reads with base correction and unmerged read inclusion
   -sed modification of output for KMC processing ease
   -Path modification for KMC use
   -KMC processing for 27mers with 25 count minimum, histogram output
   -Converts histogram file from .txt to .csv for matrix output
- **Documentation & Cleanup**:
   -Prints data on job and matrix file for documentation purposes
   -removes intermediary files
   
- **Usage**: Ensure to configure environment paths, as well as fastp and kmc commands

# K-mer matrix VST normalization script
A VST normalization script designed for large k-mer matrices 

## Workflow
- **Initialization**: Loads necessary libraries/packages 
- **Processing**: 
   -Reads matrix .csv file as a matrix
   -Performs VST
- **Documentation & output**
   - prints information on matrix dimensions for documentation purposes
   - writes normalized matrix to .csv file


   


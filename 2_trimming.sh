#!/bin/bash
#SBATCH --job-name=trimmomatic
#SBATCH --nodes=1
#SBATCH --cpus-per-task=8
#SBATCH --mem=4G
#SBATCH --time=10:00:00
#SBATCH --partition=basic
#SBATCH --output=/lisc/scratch/course/2023w300106/rochearcas/SRR24348405/trimmed_reads/trimmomatic.log
#SBATCH --error=/lisc/scratch/course/2023w300106/rochearcas/SRR24348405/trimmed_reads/trimmomatic.err

##SET UP ENVIRONMENT
module load trimmomatic/0.39
module list

##SET UP DIRECTORIES
cd /scratch/course/2023w300106/rochearcas/SRR24348405

##ACTUAL COMMAND
trimmomatic PE -threads 8 \
              SRR24348405_1.fastq SRR24348405_2.fastq \ #Input fastq reads for the trimming
              SRR24348405_R1.fastq SRR24348405_S1.fastq \ #Output files for read 1
              SRR24348405_R2.fastq SRR24348405_S2.fastq \ #OUtput files for read 2
              ILLUMINACLIP:/scratch/course/2023w300106/rochearcas/adapters.fa:2:30:10 \ #Identify adapter sequence files
              SLIDINGWINDOW:6:15 \ #In a sliding windoe of 6 bp, if the quality falls under 15, the read is discarded
              MINLEN:75

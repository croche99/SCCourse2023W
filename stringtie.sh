#!/bin/bash
#SBATCH --job-name=stringtie
#SBATCH --nodes=1
#SBATCH --cpus-per-task=8
#SBATCH --mem=2G
#SBATCH --time=10:00:00
#SBATCH --partition=basic

#Stringtie is an assembler of RNA-seq reads into potential full transcripts

module load stringtie
module list

#Move to the correct output directory
cd /scratch/course/2023w300106/rochearcas/stringtie-ex6

#Run the command
stringtie ../alignments/trimmed/SRR24348405_trimmedAligned.sortedByCoord.out.bam \ #Input bam alignment file
    -p 6 \ #Number of threads to use
    -l Nv1 \ #Name prefix
    -o NemAnnotation.gtf #Name of the output file

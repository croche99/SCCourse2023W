#!/bin/bash
#SBATCH --job-name=cellranger-single-cell
#SBATCH --nodes=1
#SBATCH --cpus-per-task=32
#SBATCH --mem=20G
#SBATCH --time=24:00:00
#SBATCH --partition=basic

module load cellranger
module list

cellranger count --id 12hr --transcriptome /scratch/course/2023w300106/rochearcas/Nvec_genome \
	--fastqs /scratch/course/2023w300106/12hr1/run1,/scratch/course/2023w300106/12hr1/run2,/scratch/course/2023w300106/12hr1/run3 \
	--sample 89085 --nosecondary --localcores 16

#Cellranger goes to the three directories and tries to find for the files beginning with the ID 89085

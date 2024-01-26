#!/bin/bash
#SBATCH --job-name=star
#SBATCH --nodes=1
#SBATCH --cpus-per-task=16
#SBATCH --mem=10G
#SBATCH --time=10:00:00
#SBATCH --partition=basic
#SBATCH --output=/scratch/course/2023w300106/rochearcas/transcriptome/star.log
#SBATCH --error=/scratch/course/2023w300106/rochearcas/transcriptome/star.err

module load star
module list

STAR --runThreadN 16 \--genomeDir /scratch/course/2023w300106/rochearcas/transcriptome/HADO01_STAR \
	--readFilesIn /scratch/course/2023w300106/rochearcas/rawreads/trimmed_reads/SRR24348405_R1.fastq  \
	/scratch/course/2023w300106/rochearcas/rawreads/trimmed_reads/SRR24348405_R2.fastq --twopassMode Basic --outFileNamePrefix SRR24348405_HADO01 \
	--outSAMtype BAM SortedByCoordinate

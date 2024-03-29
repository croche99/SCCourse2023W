#!/bin/bash
#SBATCH --job-name=star
#SBATCH --nodes=1
#SBATCH --cpus-per-task=16
#SBATCH --mem=10G
#SBATCH --time=10:00:00
#SBATCH --partition=basic
#SBATCH --output=/scratch/course/2023w300106/rochearcas/alignments/trimmed/star.log
#SBATCH --error=/scratch/course/2023w300106/rochearcas/alignments/trimmed/star.err

##loading of modules needed
module load star
module list

##preparing environment
cd /scratch/course/2023w300106/rochearcas/alignments/trimmed/


##script for STAR
STAR --runThreadN 16 \
	--genomeDir /scratch/course/2023w300106/rochearcas/genome/ncbi_dataset/data/GCF_932526225.1/jaNemVect1.1_STAR \ #Genome needs to be previously indexed
	--readFilesIn /scratch/course/2023w300106/rochearcas/rawreads/trimmed_reads/SRR24348405_R1.fastq \
 		      /scratch/course/2023w300106/rochearcas/rawreads/trimmed_reads/SRR24348405_R2.fastq \
	--outSAMtype BAM SortedByCoordinate \
 	--twopassMode Basic \
	--outSAMstrandField intronMotif \
 	--outFileNamePrefix SRR24348405_trimmed

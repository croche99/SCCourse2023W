#!/bin/bash
#SBATCH --job-name=star
#SBATCH --nodes=1
#SBATCH --cpus-per-task=16
#SBATCH --mem=10G
#SBATCH --time=10:00:00
#SBATCH --partition=basic
#SBATCH --output=/scratch/course/2023w300106/rochearcas/alignments/untrimmed/star.log
#SBATCH --error=/scratch/course/2023w300106/rochearcas/alignments/untrimmed/star.err

##loading of modules needed
module load star
module list

##preparing environment
cd /scratch/course/2023w300106/rochearcas/alignments/untrimmed/


##script for STAR
STAR --runThreadN 16 --genomeDir /scratch/course/2023w300106/rochearcas/genome/ncbi_dataset/data/GCF_932526225.1/jaNemVect1.1_STAR \
	--readFilesIn /scratch/course/2023w300106/rochearcas/rawreads/SRR24348405_1.fastq /scratch/course/2023w300106/rochearcas/rawreads/SRR24348405_2.fastq \
	--outSAMtype BAM SortedByCoordinate --twopassMode Basic \
	--outSAMstrandField intronMotif --outFileNamePrefix SRR24348405


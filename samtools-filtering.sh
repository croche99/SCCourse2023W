#!/bin/bash
#SBATCH --job-name=samtools-filtering
#SBATCH --nodes=1
#SBATCH --cpus-per-task=8
#SBATCH --mem=8G
#SBATCH --time=1:00:00
#SBATCH --partition=basic

module load samtools
module list

samtools view -b -o /scratch/course/2023w300106/BAMS/SRR24348405.f.bam -q 20 -f 0x2 -F 0x4 \
	-@ 8 /scratch/course/2023w300106/rochearcas/alignments/trimmed/SRR24348405_trimmedAligned.sortedByCoord.out.bam

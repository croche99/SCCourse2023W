#!/bin/bash
#SBATCH --job-name=samtools-filtering
#SBATCH --nodes=1
#SBATCH --cpus-per-task=8
#SBATCH --mem=8G
#SBATCH --time=1:00:00
#SBATCH --partition=basic

module load samtools
module list

samtools view -b \ #The output should be in bam format
	-o /scratch/course/2023w300106/BAMS/SRR24348405.f.bam \ #Output with the filtered alignments
 	-q 20 \ #Minimum alignment quality to pass the filtering. In this case, 1% probability of being wrongly sequenced
  	-f 0x2 \ #Flag to indicate to filter for segments properly aligned
   	-F 0x4 \ #Flag to indicate to exclude unmapped segments
	-@ 8 \ #Number of threads to run the program, must be equal or lower to resources requested
 	/scratch/course/2023w300106/rochearcas/alignments/trimmed/SRR24348405_trimmedAligned.sortedByCoord.out.bam #Input bam file for filtering

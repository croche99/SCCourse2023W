#!/bin/bash
#SBATCH --job-name=featurecounts
#SBATCH --nodes=1
#SBATCH --cpus-per-task=6
#SBATCH --mem=10G
#SBATCH --time=10:00:00
#SBATCH --partition=basic
#SBATCH --output=/scratch/course/2023w300106/rochearcas/featurecounts/featurecounts.log
#SBATCH --error=/scratch/course/2023w300106/rochearcas/featurecounts/featurecounts.err

module load subread

featureCounts -a /scratch/course/2023w300106/jmontenegro/ex2/annotation/tmp.gtf \ #Path to the annotation path
	-o countmatrixNvpooledblastula \ #Output file name
 	/scratch/course/2023w300106/rochearcas/alignments/trimmed/SRR24348405_trimmedAligned.sortedByCoord.out.bam \ #Input bam alignment
	-s 2 \ #Reversely stranded
 	-C \ #Read pairs mapping to different chromosomes and/or different strands in same chromosome are not counted
  	-p \ #Paired-end sequencing
   	-Q 20 \ #Minimum mapping quality to be valid for counting
    	--countReadPairs \ #Fragments, instead of reads, are used for counting
     	-T 16 #Number of threads used to run the command

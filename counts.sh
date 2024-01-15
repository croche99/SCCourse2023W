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
featureCounts -a /scratch/course/2023w300106/rochearcas/annotation/ncbi_dataset/data/GCF_932526225.1/genomic.gtf \
	-o countmatrixNvpooledblastula /scratch/course/2023w300106/rochearcas/alignments/trimmed/SRR24348405_trimmedAligned.sortedByCoord.out.bam \
	-s 2 -C -p -Q 20 --countReadPairs -T 16

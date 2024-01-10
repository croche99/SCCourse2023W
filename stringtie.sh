#!/bin/bash
#SBATCH --job-name=stringtie
#SBATCH --nodes=1
#SBATCH --cpus-per-task=8
#SBATCH --mem=2G
#SBATCH --time=10:00:00
#SBATCH --partition=basic

module load stringtie
module list

cd /scratch/course/2023w300106/rochearcas/stringtie-ex6
stringtie ../alignments/trimmed/SRR24348405_trimmedAligned.sortedByCoord.out.bam -p 6 -l Nv1 -o NemAnnotation.gtf

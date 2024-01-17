#!/bin/bash
#SBATCH --job-name=interproscan
#SBATCH --nodes=1
#SBATCH --cpus-per-task=16
#SBATCH --mem=10G
#SBATCH --time=10:00:00
#SBATCH --partition=basic
#SBATCH --output=/scratch/course/2023w300106/rochearcas/functionalannotation/interproscan.log
#SBATCH --error=/scratch/course/2023w300106/rochearcas/functionalannotation/interproscan.err

module load interproscan
module list

interproscan.sh -b /scratch/course/2023w300106/rochearcas/functionalannotation/NemVec.function -cpu 16 -etra -f TSV,GFF3 -goterms \
	-i /scratch/course/2023w300106/rochearcas/proteinTransdecoder.fasta -iprlookup -pa -t p
# -t type of sequence protein

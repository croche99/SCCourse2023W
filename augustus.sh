#!/bin/bash
#SBATCH --job-name=augustus-chr11
#SBATCH --nodes=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=16G
#SBATCH --time=2-00:00:00
#SBATCH --partition=basic

module load conda
conda activate augustus

cd /scratch/course/2023w300106/rochearcas
mkdir ex7
cd ex7

augustus --strand=both --genemodel=complete --gff3=on \
	--outfile=nemVec_augustus.gff --species=nematostella_vectensis \
	/scratch/course/2023w300106/rochearcas/genome/ncbi_dataset/data/GCF_932526225.1/chr11.fasta

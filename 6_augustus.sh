#!/bin/bash
#SBATCH --job-name=augustus-chr11
#SBATCH --nodes=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=16G
#SBATCH --time=2-00:00:00
#SBATCH --partition=basic

module load conda
conda activate augustus

#Choose one chromosome for gene prediction, as it is quite slow
module load samtools
more GCF_932526225.1_jaNemVect1.1_genomic.fna | grep "NC_"
samtools faidx GCF_932526225.1_jaNemVect1.1_genomic.fna NC_064044.1 > chr11.fasta

cd /scratch/course/2023w300106/rochearcas
mkdir ex7
cd ex7

augustus --strand=both \ #Search for genes in both strands
	--genemodel=complete \ #Do not predict partial or truncated genes
 	--gff3=on \  #Have the output in gff3 format
	--outfile=nemVec_augustus.gff \
 	--species=nematostella_vectensis \ #Species name exactly as it is stated in augustus species database
	/scratch/course/2023w300106/rochearcas/genome/ncbi_dataset/data/GCF_932526225.1/chr11.fasta #Genomic sequence to which the gene prediction will be made

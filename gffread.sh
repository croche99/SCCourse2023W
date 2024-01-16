#!/bin/bash
#SBATCH --job-name=gffread
#SBATCH --nodes=1
#SBATCH --cpus-per-task=16
#SBATCH --mem=10G
#SBATCH --time=1:00:00
#SBATCH --partition=basic
#SBATCH --output=/scratch/course/2023w300106/rochearcas/functionalannotation/gffread.log
#SBATCH --error=/scratch/course/2023w300106/rochearcas/functionalannotation/gffread.err

module load gffread
module load transdecoder
module list

gffread -g /scratch/course/2023w300106/rochearcas/genome/ncbi_dataset/data/GCF_932526225.1/GCF_932526225.1_jaNemVect1.1_genomic.fna \
	-w transcripts.fasta /scratch/course/2023w300106/jmontenegro/ex2/annotation/genomic.gff

TransDecoder.LongOrfs -t transcripts.fasta -S -O jaNemVec.transdecoder --complete_orfs_only

TransDecoder.Predict -t transcripts.fasta --single_best_only  -O jaNemVec.transdecoder

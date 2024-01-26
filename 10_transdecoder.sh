#!/bin/bash
#SBATCH --job-name=transdecoder
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

#Extract the transcripts from the gff file
gffread -g /scratch/course/2023w300106/rochearcas/genome/ncbi_dataset/data/GCF_932526225.1/GCF_932526225.1_jaNemVect1.1_genomic.fna #Path to genomic sequences for input files\
	-w transcripts.fasta /scratch/course/2023w300106/jmontenegro/ex2/annotation/genomic.gff #Fasta file with spliced exons for each transcript

TransDecoder.LongOrfs -t transcripts.fasta \
	-S #Only analyses top strand \
 	-O jaNemVec.transdecoder \
  	--complete_orfs_only #Only considers those starting with Met and finishing with stop codon

TransDecoder.Predict -t transcripts.fasta \
	--single_best_only  #Selects one ORF per transcript based on homology \
 	-O jaNemVec.transdecoder

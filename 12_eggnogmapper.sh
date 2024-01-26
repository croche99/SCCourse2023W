#!/bin/bash
#SBATCH --job-name=emapper
#SBATCH --nodes=1
#SBATCH --cpus-per-task=16
#SBATCH --mem=10G
#SBATCH --time=10:00:00
#SBATCH --partition=basic
#SBATCH --output=/scratch/course/2023w300106/rochearcas/functionalannotation/emapper.log
#SBATCH --error=/scratch/course/2023w300106/rochearcas/functionalannotation/emapper.err


module load conda
conda activate eggnog-mapper-2.1.12

emapper.py -i /scratch/course/2023w300106/rochearcas/functionalannotation/proteinTransdecoder.fasta \ #Input protein fasta file
	--cpu 16 \
 	--itype proteins #Type of data input \
  	--data_dir /scratch/mirror/eggnog-mapper/2.1.12 #Path to eggnog-mapper database \
   	-m diamond #Which method to look for seed orthologs \
    	--pident 60 #Use only alignments equal or above a certain percentage of identity \
     	--query_cover 60 #Use only alignments equal or above a certain percentage of query cover \
      	--subject_cover 70 #Use only alignments equal or above a certain percentage of query cover \
	--tax_scope 'eukaryota_broad' #Use only GO information belonging to eukaryota \
 	--output jaNemVect_emapper #File prefix for the output \
  	--output_dir /scratch/course/2023w300106/rochearcas/ex9 \
	--temp_dir ${TMPDIR} \
 	--decorate_gff jaNemVect_emapper.dec.gff #Add annotation information from gene prediction

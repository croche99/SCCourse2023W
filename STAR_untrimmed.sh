#!/bin/bash
#SBATCH --job-name=star
#SBATCH --nodes=1
#SBATCH --cpus-per-task=16
#SBATCH --mem=10G
#SBATCH --time=10:00:00
#SBATCH --partition=basic
#SBATCH --output=/scratch/course/2023w300106/rochearcas/alignments/untrimmed/star.log
#SBATCH --error=/scratch/course/2023w300106/rochearcas/alignments/untrimmed/star.err

##loading of modules needed
module load star
module list

##generate an indexing of the reference genome
cd /scratch/course/2023w300106/rochearcas/Nvec_genome
STAR --runThread 16 \ #Number of CPUs to run the program with, must be less or equal to the resources requested
	--runMode genomeGenerate \ #In order to index the genome in FASTA format
 	--genomeDir /scratch/course/2023w300106/rochearcas/1part/Nvec_genome/fasta \ #Path to the genome FASTA file

STAR --runMode genomeGenerate \ #In order to index the genome in FASTA format
	--runThreadN 8 \ #Number of CPUs to run the program with, must be less or equal to the resources requested
 	--genomeDir jaNemVect1.1_STAR \ #Path to the genome FASTA file
  	--genomeFastaFiles GCF_932526225.1_jaNemVect1.1_genomic.fna 
   	--genomeSAindexNbases 13 #Slightly small genome, by default is 14

	
##move to the correct environment
cd /scratch/course/2023w300106/rochearcas/alignments/untrimmed/

##script for STAR
STAR \
	--runThreadN 16 \ #Number of CPUs to use
 	--genomeDir /scratch/course/2023w300106/rochearcas/genome/ncbi_dataset/data/GCF_932526225.1/jaNemVect1.1_STAR \
	--readFilesIn /scratch/course/2023w300106/rochearcas/rawreads/SRR24348405_1.fastq \
 			/scratch/course/2023w300106/rochearcas/rawreads/SRR24348405_2.fastq \ #Paired-end sequencing, forward and reverse reads
	--outSAMtype BAM SortedByCoordinate \ #Alignments are ordered according to their position in the genome
 	--twopassMode Basic \ #Finish junctions of the first reads file before starting alignment of the second reads
	--outSAMstrandField intronMotif \ #Generate spliced alignments from unstranded RNA-seq data
 	--outFileNamePrefix SRR24348405 #Same as our sample NCBI reference


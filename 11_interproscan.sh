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

interproscan.sh -b /scratch/course/2023w300106/rochearcas/functionalannotation/NemVec.function #Output file name \
	-cpu 16 \
 	-etra #Includes sites in output \
  	-f TSV,GFF3 #Format to store the output as \
   	-goterms #Assign Gene Ontology tags \
	-i /scratch/course/2023w300106/rochearcas/functionalannotation/proteinTransdecoder.fasta #Name of input file \
 	-iprlookup #Include lookup of InterPro annotation\
  	-pa #Include lookup for pathway \
   	-t p #Type of sequence is protein

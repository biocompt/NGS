#!/bin/sh
#SBATCH -t 00:01:00
#SBATCH --job-name=multiqc_RNA
#SBATCH --mem-per-cpu=16G

module load cesga/2020 multiqc/1.10.1

FASTQC="/mnt/lustre/scratch/nlsas/home/otras/fmx/cpm/RNASEQ_CEREBRO_RATAS/FASTQC"
MULTIQC="/mnt/lustre/scratch/nlsas/home/otras/fmx/cpm/RNASEQ_CEREBRO_RATAS/MULTIQC"

multiqc $FASTQC -o $MULTIQC


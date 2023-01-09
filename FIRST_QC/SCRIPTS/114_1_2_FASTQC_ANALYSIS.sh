#!/bin/sh
#SBATCH -c 8
#SBATCH -t 00:10:00
#SBATCH --job-name=fastqc_RNA
#SBATCH --mem-per-cpu=16G

module load cesga/2020 fastqc/0.11.9
fastqc /mnt/lustre/scratch/nlsas/home/otras/fmx/cpm/RNASEQ_CEREBRO_RATAS/RAW_FASTQ/114_1_2.fastq.gz --noextract -t 64 -o /mnt/lustre/scratch/nlsas/home/otras/fmx/cpm/RNASEQ_CEREBRO_RATAS/FASTQC

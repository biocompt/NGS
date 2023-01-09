#!/bin/sh
#SBATCH -c 8
#SBATCH -t 00:10:00
#SBATCH --job-name=fastqc_RNA
#SBATCH --mem-per-cpu=16G

module load cesga/2020 fastqc/0.11.9
fastqc /mnt/lustre/scratch/nlsas/home/otras/fmx/cpm/RNASEQ_CEREBRO_RATAS/TRIMMED/124_1_2_ADAPTER_TRIMMED.fastq.gz --noextract -t 8 -o /mnt/lustre/scratch/nlsas/home/otras/fmx/cpm/RNASEQ_CEREBRO_RATAS/SECOND_FASTQC

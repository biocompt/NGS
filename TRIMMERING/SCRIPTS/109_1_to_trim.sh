#!/bin/sh
#SBATCH -c 8
#SBATCH -t 00:30:00
#SBATCH --job-name=trim_RNA
#SBATCH --mem-per-cpu=8G

module load cesga/2020 gcccore/system cutadapt/3.5

cutadapt -a AGATCGGAAGAG -A AGATCGGAAGAG -o /mnt/lustre/scratch/nlsas/home/otras/fmx/cpm/RNASEQ_CEREBRO_RATAS/TRIMMED/109_1_1_ADAPTER_TRIMMED.fastq.gz -p /mnt/lustre/scratch/nlsas/home/otras/fmx/cpm/RNASEQ_CEREBRO_RATAS/TRIMMED/109_1_2_ADAPTER_TRIMMED.fastq.gz -j 8 -q 20 	/mnt/lustre/scratch/nlsas/home/otras/fmx/cpm/RNASEQ_CEREBRO_RATAS/RAW_FASTQ/109_1_1.fastq.gz /mnt/lustre/scratch/nlsas/home/otras/fmx/cpm/RNASEQ_CEREBRO_RATAS/RAW_FASTQ/109_1_2.fastq.gz --report=minimal

TRIMMED="/mnt/lustre/scratch/nlsas/home/otras/fmx/cpm/RNASEQ_CEREBRO_RATAS/TRIMMED"
FASTQC="/mnt/lustre/scratch/nlsas/home/otras/fmx/cpm/RNASEQ_CEREBRO_RATAS/SECOND_FASTQC"
SCRIPTS="/mnt/lustre/scratch/nlsas/home/otras/fmx/cpm/RNASEQ_CEREBRO_RATAS/scripts"

mkdir $SCRIPTS/scripts_second_qc
ls $TRIMMED > $SCRIPTS/scripts_second_qc/raw_files.txt

## Create individual scripts for each fastq file
for line in $(cat $SCRIPTS/scripts_second_qc/raw_files.txt)
do
echo $line
echo "
#!/bin/sh
#SBATCH -c 8
#SBATCH -t 00:10:00
#SBATCH --job-name=fastqc_RNA
#SBATCH --mem-per-cpu=16G

module load cesga/2020 fastqc/0.11.9
fastqc $TRIMMED/$line --noextract -t 8 -o $FASTQC" > $SCRIPTS/scripts_second_qc/${line::-9}_SECOND_FASTQC_ANALYSIS.sh
done

## Remove first empty line to run sbatch
for file in $SCRIPTS/scripts_second_qc/*.sh
do
sed -i '1d' $file
done

## Run the analysis
for file in $SCRIPTS/scripts_second_qc/*.sh
do
sbatch $file
done


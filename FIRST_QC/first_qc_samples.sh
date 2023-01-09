RAW="/mnt/lustre/scratch/nlsas/home/otras/fmx/cpm/RNASEQ_CEREBRO_RATAS/RAW_FASTQ"
FASTQC="/mnt/lustre/scratch/nlsas/home/otras/fmx/cpm/RNASEQ_CEREBRO_RATAS/FIRST_FASTQC"
SCRIPTS="/mnt/lustre/scratch/nlsas/home/otras/fmx/cpm/RNASEQ_CEREBRO_RATAS/scripts"

mkdir $SCRIPTS/scripts_fastqc
ls $RAW > $SCRIPTS/scripts_fastqc/raw_files.txt

## Create individual scripts for each fastq file
for line in $(cat $SCRIPTS/scripts_fastqc/raw_files.txt)
do
echo $line
echo "
#!/bin/sh
#SBATCH -c 8
#SBATCH -t 00:10:00
#SBATCH --job-name=fastqc_RNA
#SBATCH --mem-per-cpu=16G

module load cesga/2020 fastqc/0.11.9
fastqc $RAW/$line --noextract -t 64 -o $FASTQC" > $SCRIPTS/scripts_fastqc/${line::-9}_FASTQC_ANALYSIS.sh
done

## Remove first empty line to run sbatch
for file in $SCRIPTS/scripts_fastqc/*.sh
do
sed -i '1d' $file
done

## Run the analysis
for file in $SCRIPTS/scripts_fastqc/*.sh
do
sbatch $file
done


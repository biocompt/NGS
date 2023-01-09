# ============= TRIMMERING LOW QUALITY SAMPLES =============== #
TRIMMED="/mnt/lustre/scratch/nlsas/home/otras/fmx/cpm/RNASEQ_CEREBRO_RATAS/TRIMMED"
RAW="/mnt/lustre/scratch/nlsas/home/otras/fmx/cpm/RNASEQ_CEREBRO_RATAS/RAW_FASTQ"
SCRIPTS="/mnt/lustre/scratch/nlsas/home/otras/fmx/cpm/RNASEQ_CEREBRO_RATAS/scripts"

mkdir $SCRIPTS/scripts_trimmering
cd $RAW
ls *_1.fastq.gz > $SCRIPTS/scripts_trimmering/samples_to_trim.txt
cd $SCRIPTS

## Run cutadapt to improve the quality of our smaples
for line in $(cat $SCRIPTS/scripts_trimmering/samples_to_trim.txt)
do
echo "
#!/bin/sh
#SBATCH -c 8
#SBATCH -t 00:30:00
#SBATCH --job-name=trim_RNA
#SBATCH --mem-per-cpu=8G

module load cesga/2020 gcccore/system cutadapt/3.5

cutadapt -a AGATCGGAAGAG -A AGATCGGAAGAG -o $TRIMMED/${line::-11}_1_ADAPTER_TRIMMED.fastq.gz -p $TRIMMED/${line::-11}_2_ADAPTER_TRIMMED.fastq.gz -j 8 -q 20 \
	$RAW/${line::-11}_1.fastq.gz $RAW/${line::-11}_2.fastq.gz --report=minimal" > $SCRIPTS/scripts_trimmering/${line::-11}_to_trim.sh
done

## Remove empty first line
for file in $SCRIPTS/scripts_trimmering/*.sh
do
sed -i '1d' $file
done

## Run analysis
cd $SCRIPTS/logs_trimmering
for file in $SCRIPTS/scripts_trimmering/*.sh
do
sbatch $file
done

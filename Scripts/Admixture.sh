#!/bin/bash

#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --mem=200G
#SBATCH --cpus-per-task=20
#SBATCH --job-name=admixture
#SBATCH --time=00:10:00
#SBATCH --account=a_riginos
#SBATCH --partition=general

source /QRISdata/Q5253/miniconda3/etc/profile.d/conda.sh
conda activate admixture

FILE=Spis_filtered # Change core name to perform analysis for Pver

awk '{$1="0";print $0}' $FILE.bim > $FILE.bim.tmp
mv $FILE.bim.tmp $FILE.bim

for i in {2..15}
do
 admixture --cv $FILE.bed $i > log${i}.out 
done

awk '/CV/ {print $3,$4}' *out | cut -c 4,7-20 > $FILE.cv.error

#!/bin/bash --login
#SBATCH --job-name="pixy"    # job name
#SBATCH --nodes=1				# use 1 node
#SBATCH --ntasks-per-node=1     # use 1 for single and multi core jobs
#SBATCH --cpus-per-task=1		# number of cores per job
#SBATCH --mem=100G				# RAM per job given in megabytes (M), gigabytes (G), or terabytes (T)
#SBATCH --time=1:00:00			# walltime
#SBATCH --account=a_riginos		# group account name
#SBATCH --partition=general		# queue name

module load bcftools

bcftools mpileup -f /Stylophora_pistillata_LR3SR3PC3.fa_decontaminated.fasta -b bam_files.txt | bcftools call -m -Oz -f GQ -o SpisTaxon1_allsites

module load vcftools

vcftools --gzvcf Spis_allsites.vcf.gz --remove-indels --max-missing 0.95 --recode --out Spis_allsites_SF

vcftools --gzvcf Spis_allsites_SF.recode.vcf --max-maf 0 --recode --out Spis_allsites_SF_invar

vcftools --gzvcf Spis_allsites_SF.recode.vcf.gz --mac 3 --maf 0.005 --min-alleles 2 --max-alleles 2 --max-meanDP 100 --recode --out Spis_allsites_SF_var

bgzip Spis_allsites_SF_var.recode.vcf

tabix Spis_allsites_SF_var.recode.vcf.gz

bgzip Spis_allsites_SF_invar.recode.vcf 

tabix Spis_allsites_SF_invar.recode.vcf.gz

module load bcftools

bcftools concat --allow-overlaps Spis_allsites_SF_var.recode.vcf.gz Spis_allsites_SF_invar.recode.vcf.gz -O z -o Spis_allsites_SF_combined.vcf.gz

awk '{gsub(/[lcl|contig]/,"lcl_contig"); print}' Spis_allsites_SF_combined.vcf.gz > Spis_allsites_SF_combined2.vcf.gz

tabix Spis_allsites_SF_combined2.vcf.gz

module load anaconda3/2022.05
source $EBROOTANACONDA3/etc/profile.d/conda.sh

conda activate pixy

pixy --stats pi fst dxy --vcf Spis_allsites_SF_combined2.vcf.gz --populations Spis_popfile.txt --window_size 10000 --n_cores 4

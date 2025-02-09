#!/bin/bash --login
#SBATCH --job-name="filering_spis"    # job name
#SBATCH --nodes=1				# use 1 node
#SBATCH --ntasks-per-node=1     # use 1 for single and multi core jobs
#SBATCH --cpus-per-task=1		# number of cores per job
#SBATCH --mem=100G				# RAM per job given in megabytes (M), gigabytes (G), or terabytes (T)
#SBATCH --time=1:00:00			# walltime
#SBATCH --account=a_riginos		# group account name
#SBATCH --partition=general		# queue name

#Separate Taxon1 individuals and re-run ipyrad step7

ipyrad -p params-Stylo_all.txt -b StyloTaxon1 Taxon1_individuals.txt

#Stringent filtering

vcftools --vcf StyloTaxon1.vcf --remove-indels --max-meanDP 100 --min-meanDP 5 --max-missing 0.95 --mac 3 --min-alleles 2 --max-alleles 2 --maf 0.005 --recode --out StyloTaxon1_SF095

#Prunning LD

plink --vcf StyloTaxon1_SF095.recode.vcf --allow-extra-chr --set-missing-var-ids @:# --indep 50 5 2 --double-id --out StyloTaxon1_SF095_LD
plink --vcf StyloTaxon1_SF095.recode.vcf --allow-extra-chr --set-missing-var-ids @:# --extract StyloTaxon1_SF095_LD.prune.in --double-id --recode-vcf --out StyloTaxon1_SF095_LD



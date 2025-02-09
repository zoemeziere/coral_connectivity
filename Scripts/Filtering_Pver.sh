#!/bin/bash --login
#SBATCH --job-name="filering_pver"    # job name
#SBATCH --nodes=1				# use 1 node
#SBATCH --ntasks-per-node=1     # use 1 for single and multi core jobs
#SBATCH --cpus-per-task=1		# number of cores per job
#SBATCH --mem=100G				# RAM per job given in megabytes (M), gigabytes (G), or terabytes (T)
#SBATCH --time=1:00:00			# walltime
#SBATCH --account=a_riginos		# group account name
#SBATCH --partition=general		# queue name

# Separate Pver cluster individuals and re-run ipyrad step7

ipyrad -p params-poci_all_remove1.txt -b PverTaxon1A PverTaxon1A_individuals.txt

# Stringent filtering with < 20% missing data

vcftools --vcf PverTaxon1A.vcf --remove-indels --max-meanDP 100 --min-meanDP 5 --max-missing 0.80 --mac 3 --min-alleles 2 --max-alleles 2 --maf 0.005 --recode --out PverTaxon1A_SF080

# Stringent filtering with < 15% missing data

vcftools --vcf PverTaxon1A.vcf --remove-indels --max-meanDP 100 --min-meanDP 5 --max-missing 0.85 --mac 3 --min-alleles 2 --max-alleles 2 --maf 0.005 --recode --out PverTaxon1A_SF090

# Stringent filtering with < 5% missing data

vcftools --vcf PverTaxon1A.vcf --remove-indels --max-meanDP 100 --min-meanDP 5 --max-missing 0.95 --mac 3 --min-alleles 2 --max-alleles 2 --maf 0.005 --recode --out PverTaxon1A_SF090

# Prunning LD for < 20% missing data (same for other two datasets)

plink --vcf PverTaxon1A_SF080.recode.vcf --allow-extra-chr --set-missing-var-ids @:# --indep 50 5 2 --double-id --out PverTaxon1A_SF080_LD
plink --vcf PverTaxon1a_SF080.recode.vcf --allow-extra-chr --set-missing-var-ids @:# --extract PverTaxon1A_SF080_LD.prune.in --double-id --recode-vcf --out PverTaxon1A_SF080_LD



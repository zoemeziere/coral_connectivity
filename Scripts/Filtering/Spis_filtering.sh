# Recall SNPs on Taxon1 individuals only

ipyrad -p params-Stylo_all.txt -b StyloTaxon1 Taxon1_individuals.txt
# VCF output: 232 individuals and 311879 SNPs

# Stringent filtering:

vcftools --vcf StyloTaxon1.vcf --remove-indels --max-meanDP 100 --min-meanDP 5 --max-missing 0.95 --mac 3 --min-alleles 2 --max-alleles 2 --maf 0.005 --recode --out StyloTaxon1_SF095
# VCF outputs: 232 individuals and 6453 SNPs

# Prunning LD

plink --vcf StyloTaxon1_SF095.recode.vcf --allow-extra-chr --set-missing-var-ids @:# --indep 50 5 2 --double-id --out StyloTaxon1_SF095_LD
plink --vcf StyloTaxon1_SF095.recode.vcf --allow-extra-chr --set-missing-var-ids @:# --extract StyloTaxon1_SF095_LD.prune.in --double-id --recode-vcf --out StyloTaxon1_SF095_LD
# VCF outputs: 232 individuals and 4527 SNPs



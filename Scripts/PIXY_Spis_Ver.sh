#!/bin/bash --login
#SBATCH --job-name="pixy"    # job name
#SBATCH --nodes=1				# use 1 node
#SBATCH --ntasks-per-node=1     # use 1 for single and multi core jobs
#SBATCH --cpus-per-task=1		# number of cores per job
#SBATCH --mem=100G				# RAM per job given in megabytes (M), gigabytes (G), or terabytes (T)
#SBATCH --time=1:00:00			# walltime
#SBATCH --account=a_riginos		# group account name
#SBATCH --partition=general		# queue name

module load anaconda3/2022.05
source $EBROOTANACONDA3/etc/profile.d/conda.sh

conda activate pixy

pixy --stats pi fst dxy --vcf Spis_allsites_SF_combined2.vcf.gz --populations Spis_popfile.txt --window_size 10000 --n_cores 4

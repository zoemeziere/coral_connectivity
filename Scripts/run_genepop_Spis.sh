#!/bin/bash

#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --mem=200G
#SBATCH --cpus-per-task=20
#SBATCH --job-name=genepop
#SBATCH --time=20:00:00
#SBATCH --account=a_riginos
#SBATCH --partition=general

module load r/4.2.1-foss-2022a

Rscript genepop_1d_distance0-100000.R

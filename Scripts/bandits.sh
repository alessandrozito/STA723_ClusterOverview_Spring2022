#!/bin/bash
#SBATCH --output=bandits.out
#SBATCH --job-name=bandits
#SBATCH --mail-user=vdo@duke.edu
#SBATCH --mail-type=END,FAIL  
##SBATCH --array=<FILL IN>
##SBATCH --mem-per-cpu=10G
#SBATCH --cpus-per-task=5
#SBATCH --partition=common,scavenger
module load R
R CMD BATCH --no-save test_algorithm.R out_$SLURM_ARRAY_TASK_ID
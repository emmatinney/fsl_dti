#!/bin/bash
#SBATCH --nodes=1
#SBATCH --time=24:00:00
#SBATCH --job-name=eddycorrect
#SBATCH --partition=short
#SBATCH --mail-type=END,FAIL
#SBATCH --mail-user=tinney.e@northeastern.edu

module load fsl/6.0.3-cuda9.1 

eddy_correct I387200_DOD_ADNI_GE_3T_23.0_FINA_20130507142121_7.nii 0003107_eddycorrected 0

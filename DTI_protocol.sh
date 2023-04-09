#!/bin/bash
#SBATCH --nodes=1
#SBATCH --time=24:00:00
#SBATCH --job-name=dtipp
#SBATCH --partition=short
#SBATCH --mail-type=END,FAIL
#SBATCH --mail-user=tinney.e@northeastern.edu

#after dcm2nii you should have a .nii, bvec and bval image

#load fsl
module load fsl/6.0.3-cuda9.1

#eddy correction 
#eddy_correct <input_file> <output_name> <reference_number> 
#eddy_correct I387200_DOD_ADNI_GE_3T_23.0_FINA_20130507142121_7.nii 0003107_eddycorrected 0

#fslroi
#gives us a b0 value for a brain image,
#fslroi <subject_dwi_image> <output_name> 0 1
fslroi I387200_DOD_ADNI_GE_3T_23.0_FINA_20130507142121_7.nii 0003107_dwi_b0_output 0 1 

#BET2
#run using the output of fslroi. bet2 will give us a nice mask and is formatted as follows for this purpose. -m will give you mask.nii.gz
#bet2 <b0_input> <output_name> -m -f 0.1 
bet2 0003107_dwi_b0_output.nii 0003107_bet -m -f 0.1 

#DTIFIT 
#this should output a FA brain image
#dtifit -k <eddy_result> -o <output_name> -m <mask> -r <bvec> -b <bval> 
dtifit -k 0003107_eddycorrected.nii -o 0003107_dtifitoutput.nii -m *mask.nii.gz -r *bvec -b *bval 
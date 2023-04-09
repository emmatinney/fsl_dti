#!/bin/bash
#SBATCH --nodes=1
#SBATCH --time=24:00:00
#SBATCH --job-name=tbss
#SBATCH --partition=short

#TBSS
#put all _FA.nii images in one folder
#subj=$(cat subjects.txt); for i in $subj; do 
#cp /work/cnelab/ADNIDOD/mri/ADNIDOD/0*/Axial_DTI/2*/I*/*FA.nii.gz /work/cnelab/ADNIDOD/mri/ADNIDOD/mytbss/
#cp /work/cnelab/ADNIDOD/mri/ADNIDOD/0*/Axial_DTI/2*/I*/*MD.nii.gz /work/cnelab/ADNIDOD/mri/ADNIDOD/mytbss/MD/
#cp /work/cnelab/ADNIDOD/mri/ADNIDOD/0*/Axial_DTI/2*/I*/*MO.nii.gz /work/cnelab/ADNIDOD/mri/ADNIDOD/mytbss/MO/
#cp /work/cnelab/ADNIDOD/mri/ADNIDOD/0*/Axial_DTI/2*/I*/*L1.nii.gz /work/cnelab/ADNIDOD/mri/ADNIDOD/mytbss/L1/
#cp /work/cnelab/ADNIDOD/mri/ADNIDOD/0*/Axial_DTI/2*/I*/*L2.nii.gz /work/cnelab/ADNIDOD/mri/ADNIDOD/mytbss/L2/
#cp /work/cnelab/ADNIDOD/mri/ADNIDOD/0*/Axial_DTI/2*/I*/*L3.nii.gz /work/cnelab/ADNIDOD/mri/ADNIDOD/mytbss/L3/
#done

#load fsl
module load fsl
#TBSS_1_PREPROC
#erode FA images slightly and zero the end slices
#tbss_1_preproc *.nii.gz

#TBSS_2_REG
#nonlinear registration
#tbss_2_reg -T

#TBSS_3_POSTREG
#applies non linear transform to bring subjects into standard space.
#-S derive the mean FA and skeleton from the actual subjects you have. -T uses  FMRIB58_FA mean FA image and its derived skeleton. 
#tbss_3_postreg -S

#TBSS_4_PRESTATS
#threshold mean FA skeleton at a common threshold.
#tbss_4_prestats 0.2
#cd FA
#imglob *_FA.*
#cd stats
#design matrix setting one group first, then other. specify how many in each group
#contrast 1 gives x>y and contrast 2 gives y>x 
#design_ttest2 design 98 148
#randomise -i all_FA_skeletonised -o tbss -m mean_FA_skeleton_mask -d design.mat -t design.con -n 500 --T2

#threshold tbss_tfce_corrp_tstat1.nii.gz at .95 in fsleyes

cd stats
#extract mean values from significant clusters:
fslmaths FA_tbss_tfce_corrp_tstat2.nii.gz -thrp .95 FA_thrp_stat2.nii.gz
fslmaths FA_thrp_stat2.nii.gz -mas all_FA_skeletonised.nii.gz FA_stat2_masked_4D
fslmeants -i all_FA_skeletonised.nii.gz -m FA_stat2_masked_4D.nii.gz -o FA_meants_roi2.txt
fslmaths FA_tbss_tfce_corrp_tstat1.nii.gz -thrp .95 FA_thrp_stat1.nii.gz
fslmaths FA_thrp_stat1.nii.gz -mas all_FA_skeletonised.nii.gz FA_stat1_masked_4D
fslmeants -i all_FA_skeletonised.nii.gz -m FA_stat1_masked_4D.nii.gz -o FA_meants_roi1.txt
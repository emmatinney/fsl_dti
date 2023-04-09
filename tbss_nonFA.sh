#!/bin/bash
#SBATCH --nodes=1
#SBATCH --time=24:00:00
#SBATCH --job-name=tbssnonFA
#SBATCH --partition=short

#TBSS
#nonFA images
module load fsl
#MD
#tbss_non_FA MD
#cd MD
#imglob *_FA.*
#cd ../stats
#design_ttest2 design 98 148
#randomise -i all_MD_skeletonised -o tbss -m mean_FA_skeleton_mask -d design.mat -t design.con -n 500 --T2

#L1
#tbss_non_FA L1
#cd L1
#imglob *_FA.*
#cd ../stats
#design_ttest2 design 98 148
#randomise -i all_L1_skeletonised -o tbss -m mean_FA_skeleton_mask -d design.mat -t design.con -n 500 --T2
#fslmaths L1_tbss_tfce_corrp_tstat2.nii.gz -thrp .95 AD_thrp_stat2.nii.gz
#fslmaths AD_thrp_stat2.nii.gz -mas all_L1_skeletonised.nii.gz AD_stat2_masked_4D
#fslmeants -i all_L1_skeletonised.nii.gz -m AD_stat2_masked_4D.nii.gz -o AD_meants_roi2.txt
#fslmaths L1_tbss_tfce_corrp_tstat1.nii.gz -thrp .95 AD_thrp_stat1.nii.gz
#fslmaths AD_thrp_stat1.nii.gz -mas all_L1_skeletonised.nii.gz AD_stat1_masked_4D
#fslmeants -i all_L1_skeletonised.nii.gz -m AD_stat1_masked_4D.nii.gz -o AD_meants_roi1.txt
#L2
tbss_non_FA L1
cd L1
imglob *_FA.*
cd ../stats
randomise -i all_L1_skeletonised -o tbss -m mean_FA_skeleton_mask -d design_sleep.mat -t design_sleep.con -n 500 --T2
fslmaths tbss_tfce_corrp_tstat2.nii.gz -thrp .95 L1_thrp_stat2.nii.gz
fslmaths L1_thrp_stat2.nii.gz -mas all_L1_skeletonised.nii.gz L1_stat2_masked_4D
fslmeants -i all_L1_skeletonised.nii.gz -m L1_stat2_masked_4D.nii.gz -o L1_meants_roi2.txt
fslmaths L1_tbss_tfce_corrp_tstat1.nii.gz -thrp .95 L1_thrp_stat1.nii.gz
fslmaths L1_thrp_stat1.nii.gz -mas all_L1_skeletonised.nii.gz L1_stat1_masked_4D
fslmeants -i all_L1_skeletonised.nii.gz -m L1_stat1_masked_4D.nii.gz -o L1_meants_roi1.txt
#L3
#tbss_non_FA L3
#cd L3
#imglob *_FA.*
#cd ../stats
#design_ttest2 design 98 148
#randomise -i all_L3_skeletonised -o tbss -m mean_FA_skeleton_mask -d design.mat -t design.con -n 500 --T2
#fslmaths L3_tbss_tfce_corrp_tstat2.nii.gz -thrp .95 L3_thrp_stat2.nii.gz
#fslmaths L3_thrp_stat2.nii.gz -mas all_L3_skeletonised.nii.gz L3_stat2_masked_4D
#fslmeants -i all_L3_skeletonised.nii.gz -m L3_stat2_masked_4D.nii.gz -o L3_meants_roi2.txt
#fslmaths L3_tbss_tfce_corrp_tstat1.nii.gz -thrp .95 L3_thrp_stat1.nii.gz
#fslmaths L3_thrp_stat1.nii.gz -mas all_L3_skeletonised.nii.gz L3_stat1_masked_4D
#fslmeants -i all_L3_skeletonised.nii.gz -m L3_stat1_masked_4D.nii.gz -o L3_meants_roi1.txt
#MO
#tbss_non_FA MO
#cd MO
#imglob *_FA.*
#cd ../stats
#design_ttest2 design 98 148
#randomise -i all_MO_skeletonised -o tbss -m mean_FA_skeleton_mask -d design.mat -t design.con -n 500 --T2
#fslmaths MO_tbss_tfce_corrp_tstat2.nii.gz -thrp .95 MO_thrp_stat2.nii.gz
#fslmaths MO_tbss_tfce_corrp_tstat1.nii.gz -thrp .95 MO_thrp_stat1.nii.gz
#fslmaths MO_thrp_stat2.nii.gz -mas all_MO_skeletonised.nii.gz MO_stat2_masked_4D
#fslmaths MO_thrp_stat1.nii.gz -mas all_MO_skeletonised.nii.gz MO_stat1_masked_4D
#fslmeants -i all_MO_skeletonised.nii.gz -m MO_stat1_masked_4D.nii.gz -o MO_meants_roi1.txt
#fslmeants -i all_MO_skeletonised.nii.gz -m MO_stat2_masked_4D.nii.gz -o MO_meants_roi2.txt

#!/bin/bash




sublist='nw156 sa121 sa122 sa124 sa147 sa175 sa176 sa177 sa201 sa217 sa219 sa275 sa279 sa300 sa318 sa337 sa509 sa513 sa530 sa567'
seslist='Rpre Rpost Epre Epost'

maindir=/work/hillman/folders/TrevorC/ICANN_20/rawdata_Cleaned_02       # adjust path to your env
acqparams=${maindir}/acqparams.txt # user created file with rows of [x y z TotalReadoutTime] 
config_file=${maindir}/b02b0.cnf  # user created file from FSL documentation

for i in $sublist; do
for j in $seslist; do

loopdir=${maindir}/sub-${i}/ses-${j}/fmap
fmap_AP=${loopdir}/sub-${i}_ses-${j}_run-01_dir-ap.nii.gz
fmap_PA=${loopdir}/sub-${i}_ses-${j}_run-02_dir-pa.nii.gz
outmerge="${loopdir}/sub_${i}_ses-${j}_merged_ap_pa.nii.gz"    # label for fslmerge output
outtopup="${loopdir}/sub_${i}_ses-${j}_topup"    # label for topup outputs

echo $i $j
ls $fmap_AP 
ls $fmap_PA
fslmerge -t ${outmerge} ${fmap_AP} ${fmap_PA}    # remember in which order you passed inputs 

topup --imain=${outmerge} --datain=${acqparams} --config=${config_file}  --out=${outtopup}_out --iout=${outtopup}_iout --fout=${outtopup}_fout

done
done

echo "Finished"

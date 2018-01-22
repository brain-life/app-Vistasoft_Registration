mv data_acpc.nii.gz dwi.nii.gz;
mv bvecs_rot dwi.bvecs;
mv ${bvals} dwi.bvals;
rm -rf *nodif*;

echo "DWI Registration Pipeline Complete"
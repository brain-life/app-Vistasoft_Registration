echo "Setting file paths"
# Grab the config.json inputs
dwi=`./jq -r '.dwi' config.json`;
bvals=`./jq -r '.bvals' config.json`;
bvecs=`./jq -r '.bvecs' config.json`;
t1=`./jq -r '.t1' config.json`;
echo "Files loaded"

# Create b0 image
select_dwi_vols \
	${dwi} \
	${bvals} \
	nodif.nii.gz \
	0;

# Brain extraction before alignment
bet nodif.nii.gz \
	nodif_brain \
	-f 0.4 \
	-g 0 \
	-m;

echo "b0 brainmask creation complete"
#!/bin/bash
echo "Setting file paths"
# Grab the config.json inputs
dwi=`jq -r '.dwi' config.json`;
bvals=`jq -r '.bvals' config.json`;
#bvecs=`./jq -r '.bvecs' config.json`;
#t1=`./jq -r '.t1' config.json`;
echo "Files loaded"

source ${FSLDIR}/etc/fslconf/fsl.sh

d=$dwi
b=`cat $bvals`
o=nodif.nii.gz

cnt=0
list="" 
for i in $b;do
    j=`echo $i | awk -F"E" 'BEGIN{OFMT="%10.10f"} {print $1 * (10 ^ $2)}' `
    j=${j/.*}   
    j=`echo "$j - 0" |bc | awk ' { if($1>=0) { print $1} else {print $1*-1 }}'`
    if [ $j -lt 100 ];then
	if [ "${list}" == "" ];then
	    list="${cnt}"
	else
	    list="${list},${cnt}"
	fi
    fi
    cnt=$(($cnt + 1))
done

echo $FSLDIR/bin/fslselectvols -i $d -o $o --vols=$list $5
fslselectvols -i $d -o $o --vols=$list $5

# Brain extraction before alignment
bet nodif.nii.gz \
	nodif_brain \
	-f 0.4 \
	-g 0 \
	-m;

echo "b0 brainmask creation complete"

#!/bin/bash
module load matlab/2017a

cat > build.m <<END
addpath(genpath('/N/u/brlife/git/vistasoft'))
addpath(genpath('/N/soft/mason/SPM/spm8'))
<<<<<<< HEAD
mcc -m -R -nodisplay -d compiled main
=======
mcc -m -R -nodisplay -d compiled vistasoftregistration
>>>>>>> 85040d38e475b65dfbbdeae5f056022f1ded5574
exit
END
matlab -nodisplay -nosplash -r build

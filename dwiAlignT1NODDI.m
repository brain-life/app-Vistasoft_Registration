function out = dwiAlignT1NODDI()

%%  Will align multi-shell dwi to ACPC aligned T1 and rotate the bvecs.  Needs vistasoft ((C) Vista lab, Stanford University)

switch getenv('ENV')
case 'IUHPC'
  disp('loading paths (HPC)')
  addpath(genpath('/N/u/hayashis/BigRed2/git/vistasoft'))
case 'VM'
  disp('loading paths (VM)')
  addpath(genpath('/usr/local/vistasoft'))
end


% Set directories
config = loadjson('config.json');
dwiRaw = fullfile(config.dwi);
bvecs_pre = fullfile(config.bvecs);
b0 = fullfile('nodif_brain.nii.gz');
t1 = fullfile(config.t1);
outAcpcTransform = fullfile('acpcTransform.mat');
outMm = [2 2 2];
outDwi = fullfile('data_acpc.nii.gz');
outBvecs = fullfile('bvecs_rot');

% Get transformation matrix
dtiRawAlignToT1(b0,t1,outAcpcTransform);

% Run Alignment
dtiRawResample(dwiRaw,[],outAcpcTransform,outDwi,[0 0 0 0 0 0],[2 2 2]);

% Rotate bvecs
bvecs = dtiRawReorientBvecs(bvecs_pre,[],outAcpcTransform,outBvecs);
exit;
end

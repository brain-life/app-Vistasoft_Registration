function out = main()

%%  Will align multi-shell dwi to ACPC aligned T1 and rotate the bvecs.  Needs vistasoft ((C) Vista lab, Stanford University)

switch getenv('ENV')
case 'IUHPC'
  disp('loading paths (HPC)')
  addpath(genpath('/N/u/hayashis/BigRed2/git/vistasoft'))
case 'VM'
  disp('loading paths (VM)')
  addpath(genpath('/usr/local/vistasoft'))
end

config = loadjson('config.json');

if isempty(config.resolution)
  % to find resolution
  disp('loading dwi resolution')
  dwi = niftiRead(config.dwi);
  outresolution = dwi.pixdim(1:3);
  clear dwi
else
  outresolution = str2num(config.resolution);
end

switch config.interpolation
  case {'linear'}
    interpolation = [0 0 0 0 0 0];
  case {'trilinear'}
    interpolation = [1 1 1 0 0 0];
  case {'spline'}
    interpolation = [7 7 7 0 0 0];
  otherwise
    error('Interpolation method not defined: %s.',config.interpolation);
end 

% Set directories
dwiRaw = fullfile(config.dwi);
bvecs_pre = fullfile(config.bvecs);
b0 = fullfile('nodif_brain.nii.gz');
t1 = fullfile(config.t1);
outAcpcTransform = fullfile('acpcTransform.mat');
outDwi = fullfile('data_acpc.nii.gz');
outBvecs = fullfile('bvecs_rot');

% Get transformation matrix
dtiRawAlignToT1(b0,t1,outAcpcTransform);

% Run Alignment
dtiRawResample(dwiRaw,[],outAcpcTransform,outDwi,interpolation,outresolution);

% Rotate bvecs
bvecs = dtiRawReorientBvecs(bvecs_pre,[],outAcpcTransform,outBvecs);
exit;
end


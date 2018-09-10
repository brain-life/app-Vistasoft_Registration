[![Abcdspec-compliant](https://img.shields.io/badge/ABCD_Spec-v1.1-green.svg)](https://github.com/soichih/abcd-spec)
[![Run on Brainlife.io](https://img.shields.io/badge/Brainlife-bl.app.1-blue.svg)](https://doi.org/10.25663/bl.app.1)

# app-vistasoft-registration
This app will register a DWI image to a T1w image and rotate the bvecs. First, a brainmask is created of from the DWI image using FSL's bet function by running the brainmask script. Then, the brainmask image is aligned to the T1 using Vistasoft's dtiRawAlignToT1 function. The transformation matrix from this is then used to resample the DWI image using Vistasoft's dtiRawResample function. Finally, the bvecs are rotated based on the transformation using Vistasoft's dtiRawReorientBvecs function. These last three steps are all performed by running the main script.

#### Authors
- Brad Caron (bacaron@iu.edu)
- Soichi Hayashi (hayashi@iu.edu)
- Franco Pestilli (franpest@indiana.edu)

## Running the App 

### On Brainlife.io

You can submit this App online at [https://doi.org/10.25663/bl.app.50](https://doi.org/10.25663/bl.app.50) via the "Execute" tab.

### Running Locally (on your machine)

1. git clone this repo.
2. Inside the cloned directory, create `config.json` with something like the following content with paths to your input files.

```json
{
        "t1": "./input/t1/t1.nii.gz",
        "dwi": "./input/dwi/dwi.nii.gz",
        "bvals": "./input/dwi/dwi.bvals",
        "bvecs": "./input/dwi/dwi.bvecs",
        "interpolation": "linear",
}
```

### Sample Datasets

You can download sample datasets from Brainlife using [Brainlife CLI](https://github.com/brain-life/cli).

```
npm install -g brainlife
bl login
mkdir input
bl dataset download 5a14aa2deb00be0031340618 && mv 5a14aa2deb00be0031340618 input/t1
bl dataset download 5a14a976eb00be0031340617 && mv 5a14a976eb00be0031340617 input/dwi

```


3. Launch the App by executing `main`

```bash
./main
```

## Output

The main output of this App is a dwi.nii.gz, along with the bvals and bvecs. These can then be used in any app requiring a dwi file.

#### Product.json
The secondary output of this app is `product.json`. This file allows web interfaces, DB and API calls on the results of the processing. 

### Dependencies

This App requires the following libraries when run locally.

  - singularity: https://singularity.lbl.gov/
  - VISTASOFT: https://github.com/vistalab/vistasoft/
  - SPM 8: https://www.fil.ion.ucl.ac.uk/spm/software/spm8/
  - FSL: https://hub.docker.com/r/brainlife/fsl/tags/5.0.9
  - jsonlab: https://github.com/fangq/jsonlab.git

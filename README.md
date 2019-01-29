[![Abcdspec-compliant](https://img.shields.io/badge/ABCD_Spec-v1.1-green.svg)](https://github.com/brain-life/abcd-spec)
[![Run on Brainlife.io](https://img.shields.io/badge/Brainlife-bl.app.50-blue.svg)](https://doi.org/10.25663/bl.app.50)

# app-vistasoft-registration
This app will align DWI data to a T1 structural image and rotate the b-vectors accordingly. This is done using VISTASOFT internal code. Inputs are a DWI and a T1 images, output is an aligned DWI datatype.

### Authors
- Brad Caron (bacaron@iu.edu)

### Contributors
- Soichi Hayashi (hayashi@iu.edu)
- Franco Pestilli (franpest@indiana.edu)

### Funding
[![NSF-BCS-1734853](https://img.shields.io/badge/NSF_BCS-1734853-blue.svg)](https://nsf.gov/awardsearch/showAward?AWD_ID=1734853)
[![NSF-BCS-1636893](https://img.shields.io/badge/NSF_BCS-1636893-blue.svg)](https://nsf.gov/awardsearch/showAward?AWD_ID=1636893)

## Running the App 

### On Brainlife.io

You can submit this App online at [https://doi.org/10.25663/bl.app.153](https://doi.org/10.25663/bl.app.50) via the "Execute" tab.

### Running Locally (on your machine)

1. git clone this repo.
2. Inside the cloned directory, create `config.json` with something like the following content with paths to your input files.

```json
{
        "t1": "./input/t1/t1.nii.gz",
        "dwi": "./input/dwi/dwi.nii.gz",
        "bvals": "./input/dwi/dwi.bvals",
        "bvecs": "./input/dwi/dwi.bvecs"
}
```

### Sample Datasets

You can download sample datasets from Brainlife using [Brainlife CLI](https://github.com/brain-life/cli).

```
npm install -g brainlife
bl login
mkdir input
bl dataset download 5b96bbbf059cf900271924f2 && mv 5b96bbbf059cf900271924f2 input/t1
bl dataset download 5b96bbf2059cf900271924f3 && mv 5b96bbf2059cf900271924f3 input/dwi

```


3. Launch the App by executing `main`

```bash
./main
```

## Output

The main output of this App is DWI datatype that's aligned to the T1.

#### Product.json
The secondary output of this app is `product.json`. This file allows web interfaces, DB and API calls on the results of the processing. 

### Dependencies

This App requires the following libraries when run locally.

  - singularity: https://singularity.lbl.gov/
  - VISTASOFT: https://github.com/vistalab/vistasoft/
  - jsonlab: https://github.com/fangq/jsonlab.git

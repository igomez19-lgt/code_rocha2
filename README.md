# Numerical Calibration of Rock Specimens Based on ANSYS Modal Analysis

---

##  Overview

This repository contains MATLAB scripts developed for the **calibration of a finite element model** of basalt specimens using **modal analysis performed in ANSYS**.

The workflow enables an automated and reproducible procedure for:
- Updating elastic material properties  
- Generating ANSYS input files from a template  
- Running simulations in batch mode  
- Extracting natural frequencies  
- Calibrating model parameters through optimization  

The primary goal is to match numerical predictions with **experimental flexural and torsional natural frequencies**.

---

## Objective

The objective of this project is to estimate material parameters that minimize the discrepancy between:

- Numerical natural frequencies (computed in ANSYS)  
- Experimental reference frequencies  

The calibration focuses on:
- Young’s modulus (E)  
- Poisson’s ratio (ν)  

---

##  Methodology

The calibration procedure follows these steps:

1. Define initial guesses for material parameters  
2. Update the ANSYS input file using a parameterized template  
3. Run ANSYS modal analysis in batch mode  
4. Extract computed natural frequencies  
5. Evaluate the objective function (error metric)  
6. Optimize parameters using MATLAB  

---

##  Repository Structure

```
.
├── Funobj2_Prima_trans_iso_BasaltoIrregular1.m
├── Run_opt_Prima_trans_iso_BasaltoIrregular1.m
├── Run_ansys_prisma_Prima_trans_iso_BasaltoIrregular1.m
├── Prima_trans_iso_BasaltoIrregular1.txt
├── Prima_trans_iso_Final_BasaltoIrregular1.txt
├── frequencias1.txt
└── README.md
```

---

##  Requirements

- MATLAB  
- ANSYS Mechanical APDL (batch mode enabled)  
- Windows OS (required for ANSYS execution path)  

---

##  How to Use

### 1. Prepare ANSYS Template

Ensure the template file:

`Prima_trans_iso_BasaltoIrregular1.txt`

contains the following placeholders:

```
E_X, E_Y, E_Z  
PR_XY, PR_YZ, PR_XZ  
G_XY, G_YZ, G_XZ  
```

These placeholders are automatically replaced by MATLAB during execution.

---

### 2. Configure ANSYS Path

Update the ANSYS executable path if necessary:

```matlab
!"C:\Program Files\ANSYS Inc\v192\ansys\bin\winx64\ANSYS192.exe"
```

---

### 3. Run a Single Simulation

Execute in MATLAB:

`Run_ansys_prisma_Prima_trans_iso_BasaltoIrregular1`

This step:
- Updates material parameters  
- Runs ANSYS in batch mode  
- Extracts natural frequencies  

---

### 4. Run Calibration (Optimization)

Execute:

`Run_opt_Prima_trans_iso_BasaltoIrregular1`

This step:
- Minimizes the objective function  
- Calibrates material parameters  
- Returns optimized values  

---

##  Objective Function

The error function is defined as:
```
Error = w_flex · |(f_num² − f_ref²) / f_ref²|  
        + w_tors · |(f_num² − f_ref²) / f_ref²|

Where:
- f_num = numerical frequency  
- f_ref = experimental/reference frequency  
```

##  Output

The workflow provides:

- Calibrated material parameters:
  - Young’s modulus (E)  
  - Poisson’s ratio (ν)  

- Natural frequencies:
  - Flexural mode  
  - Torsional mode  

- Optimization convergence history  

---

##  Assumptions

- Linear elastic and isotropic material behavior  
- Shear modulus computed as:

G = E / (2 · (1 + ν))

- ANSYS executed in batch mode  
- Fixed and consistent output file format  

---

##  Limitations

- No error handling for ANSYS execution failures  
- Sequential execution (no parallelization)  
- Manual configuration of file paths required  
- Dependence on external ANSYS installation  

---

##  Suggested Improvements

- Parallel execution of simulations  
- Use another optimization methods (e.g., `lsqnonlin`)  
- Implementation of logging and error handling  
- Automated mesh sensitivity analysis  

---

##  Applications

- Rock mechanics and geomaterials characterization  
- Finite element model updating  
- Structural dynamics analysis  
- Non-destructive evaluation  

---

##  Author

Developed by researchers from the Federal University of Latin American Integration (UNILA):

- Jair Stivenz Castaño Delgado  
- Gisele Suhett Helmer  
- Diego Moraes Flores  
- Adalto Gonçalves de Lima  
- Ivan Dario Gomez Araujo
---



# Numerical Calibration of Basalt Specimens using ANSYS Modal Analysis

![Build Status](https://img.shields.io/badge/build-passing-brightgreen)
![DOI](https://img.shields.io/badge/DOI-10.0000%2Fexample-blue)
![License](https://img.shields.io/badge/license-MIT-green)

##  Overview

This repository provides MATLAB scripts for the **calibration of a numerical finite element model** of basalt specimens using **modal analysis in ANSYS**.

The workflow automates:
- Updating material properties
- Generating ANSYS input files
- Running simulations in batch mode
- Extracting natural frequencies
- Calibrating parameters via optimization

The goal is to match numerical results with **experimental flexural and torsional frequencies**.

---

##  Objective

The main objective is to estimate material parameters that minimize the difference between:

- Numerical natural frequencies (ANSYS)
- Experimental reference frequencies

The calibration focuses on:
- Young’s modulus (E)
- Poisson’s ratio (ν)

---

##  Methodology

The process follows these steps:

1. Define initial material parameters  
2. Update ANSYS input file (template-based)  
3. Run ANSYS modal analysis (batch mode)  
4. Extract computed natural frequencies  
5. Evaluate objective function  
6. Optimize parameters using MATLAB  

---

##  Repository Structure


├── Funobj2_Prima_trans_iso_BasaltoIrregular1.m
├── Run_opt_Prima_trans_iso_BasaltoIrregular1.m
├── Run_ansys_prisma_Prima_trans_iso_BasaltoIrregular1.m
├── Prima_trans_iso_BasaltoIrregular1.txt
├── Prima_trans_iso_Final_BasaltoIrregular1.txt
├── frequencias1.txt
└── README.md

---

## ⚙️ Requirements

- MATLAB  
- ANSYS Mechanical APDL (batch mode enabled)  
- Windows OS  

---

##  How to Use

### 1. Prepare ANSYS Template

Ensure the template file: Prima_trans_iso_BasaltoIrregular1.txt

contains:

E_X, E_Y, E_Z
PR_XY, PR_YZ, PR_XZ
G_XY, G_YZ, G_XZ


---

### 2. Configure ANSYS Path

```matlab
!"C:\Program Files\ANSYS Inc\v192\ansys\bin\winx64\ANSYS192.exe"

## 🚀 Usage

### 3. Run a Single Simulation

Execute the following script in MATLAB:

`run_simulation`

This will:
- Update material parameters  
- Run ANSYS in batch mode  
- Extract natural frequencies  

---

### 4. Run Calibration

Execute:

`main_optimization`

This will:
- Minimize the objective function  
- Calibrate material properties  
- Output optimized parameters  

---

## 📐 Objective Function

The error is defined as:

Error = w_flex · |(f_num² - f_ref²) / f_ref²| + w_tors · |(f_num² - f_ref²) / f_ref²|

Where:
- f_num: numerical frequency  
- f_ref: experimental/reference frequency  

---

## 📊 Output

- Calibrated material parameters:
  - Young’s modulus (E)
  - Poisson’s ratio (ν)

- Natural frequencies:
  - Flexural mode
  - Torsional mode

- Optimization convergence history  

---

## 🧪 Assumptions

- Isotropic material behavior  
- Shear modulus computed as:

G = E / (2 · (1 + ν))

- ANSYS executed in batch mode  
- Fixed and consistent output format  

---

## ⚠️ Limitations

- No error handling for ANSYS execution  
- Sequential execution (no parallelization)  
- Manual configuration of file paths  

---

## 🔧 Suggested Improvements

- Parallel execution of simulations  
- Use of robust optimization methods (lsqnonlin)  
- Implementation of logging system  
- Mesh sensitivity analysis  

---

## 📚 Applications

- Rock mechanics  
- Finite element model updating  
- Structural dynamics  

---

## 👤 Author

Developed for academic research in numerical modeling of geomaterials.


# Numerical Calibration of Basalt Specimens using ANSYS Modal Analysis

![Build Status](https://img.shields.io/badge/build-passing-brightgreen)
![DOI](https://img.shields.io/badge/DOI-10.0000%2Fexample-blue)
![License](https://img.shields.io/badge/license-MIT-green)

## 📌 Overview

This repository provides MATLAB scripts for the **calibration of a numerical finite element model** of basalt specimens using **modal analysis in ANSYS**.

The workflow automates:
- Updating material properties
- Generating ANSYS input files
- Running simulations in batch mode
- Extracting natural frequencies
- Calibrating parameters via optimization

The goal is to match numerical results with **experimental flexural and torsional frequencies**.

---

## 🎯 Objective

The main objective is to estimate material parameters that minimize the difference between:

- Numerical natural frequencies (ANSYS)
- Experimental reference frequencies

The calibration focuses on:
- Young’s modulus (E)
- Poisson’s ratio (ν)

---

## 🧠 Methodology

The process follows these steps:

1. Define initial material parameters  
2. Update ANSYS input file (template-based)  
3. Run ANSYS modal analysis (batch mode)  
4. Extract computed natural frequencies  
5. Evaluate objective function  
6. Optimize parameters using MATLAB  

---

## 📁 Repository Structure


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

## 🚀 How to Use

### 1. Prepare ANSYS Template

Ensure the template file:


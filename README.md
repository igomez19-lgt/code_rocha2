
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


# code_rocha2
Example of computational code for calibrating a three-dimensional rock model.

Example of computational code for calibrating a three-dimensional rock model. ###################################################################################################################

The file Run_opt_Prima_trans_iso_BasaltoIrregular1.m implements a numerical optimization procedure aimed at calibrating the elastic properties of a three-dimensional rock model based on experimentally measured natural frequencies.

Initially, two global variables are defined to store the target dynamic properties obtained experimentally:

Fflex = 8226.6 Hz: flexural natural frequency Ftor = 10007.8 Hz: torsional natural frequency

These values represent the reference data used in the calibration process.

The code then performs a preprocessing step by scanning a specified directory and deleting previously generated files that match a given pattern (file). This ensures that residual data from earlier simulations do not interfere with the current optimization process.

Next, the optimization problem is defined. The number of design variables is set to two (nvar = 2), which typically correspond to material parameters such as:

Elastic modulus (E) Poisson’s ratio (ν)

An initial guess vector xo is provided:

xo(1) = 8 → initial estimate of the elastic parameter (scaled) xo(2) = 0.23 → initial estimate of Poisson’s ratio (scaled)

The optimization is carried out using the Nelder–Mead simplex algorithm via the fminsearch function. This method is derivative-free and suitable for nonlinear problems where gradient information may not be available.

##########################################################################################################################

The function Funobj2_Prima_trans_iso_BasaltoIrregular1.m defines the objective function used in the optimization process to calibrate the elastic properties of a three-dimensional isotropic basalt rock model.

The function takes as input a vector x containing the design variables and returns a scalar value yout, which represents the error between experimental and numerically computed natural frequencies.

Initially, the function accesses the global variables Fflex and Ftor, which store the experimentally measured flexural and torsional natural frequencies, respectively. These values serve as reference targets for the calibration.

The design variables are then converted into physical material properties:

The elastic modulus is defined as Modulo = x(1) × 10¹⁰, scaling the optimization variable to the appropriate magnitude.

The Poisson’s ratio is defined as Poisson = x(2), considering a scaling factor.

Based on these parameters, the function constructs a isotropic elastic model, assuming equal properties in the principal directions:

Next, the function generates an input file for the numerical simulation. It reads a template file (Prima_trans_iso_BasaltoIrregular1.txt) and replaces placeholder strings (e.g., E_X, PR_XY, etc.) with the current values of the material parameters. The modified content is then written to a new file (Prima_trans_iso_Final_BasaltoIrregular1.txt), which serves as input for the finite element model.

The numerical simulation is executed externally using ANSYS in batch mode via a system command. This step runs the finite element analysis with the updated material properties.

After the simulation, the function imports the computed natural frequencies from the file frequencias1.txt. These frequencies correspond to the vibration modes of the numerical model.

The objective function is then evaluated by comparing the numerical and experimental frequencies. A weighted error metric is defined as:

The squared difference between numerical and experimental frequencies
Normalized by the experimental values
Combined using weighting factors for flexural and torsional modes
Specifically, the function computes a normalized absolute error based on the squared frequencies, ensuring sensitivity to dynamic stiffness variations.

Finally, the function returns a scalar value yout, which represents the total discrepancy between the model and the experimental data. This value is minimized during the optimization process, leading to the identification of the material parameters that best reproduce the observed dynamic behavior.

#####################################################################

global Ftor Fflex

% Target natural frequencies (experimental or reference values)
Fflex = 8226.6;  % Flexural frequency (Hz)
Ftor  = 10007.8; % Torsional frequency (Hz)

% --- Clean working directory ---
% Remove previous result files to avoid interference with new simulations
folder = 'C:\Dados GEO\Artigo Rochas\1.Iteracao2mm';
files = dir(fullfile(folder, '*file*'));

for k = 1:length(files)
    filePath = fullfile(folder, files(k).name);
    delete(filePath);
end

% --- Optimization problem setup ---
nvar = 2;          % Number of design variables
scale_2 = 1e-0;    % Scaling factor

% Initial guess for optimization variables
% x(1): Young's modulus scaling
% x(2): Poisson's ratio
xo(1,1) = 8;
xo(2,1) = 0.23 * scale_2;

% Bounds (not used by fminsearch, but kept for reference)
lb = [7   0.1 * scale_2];
ub = [9   0.4 * scale_2];

% --- Optimization options ---
options = optimset('Display','iter', ...
                   'PlotFcns', @optimplotfval);

% --- Run optimization ---
% Minimizes the objective function based on ANSYS modal analysis
[x, fval, exitflag, output] = ...
    fminsearch(@Funobj2_Prima_trans_iso_BasaltoIrregular1, xo, options);

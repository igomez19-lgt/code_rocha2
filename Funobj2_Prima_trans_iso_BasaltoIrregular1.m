

function yout = Funobj2_Prima_trans_iso_BasaltoIrregular1(x)

% Objective function for calibration of a numerical model (ANSYS-based)
% The function updates material properties, runs the simulation,
% and computes the error between numerical and reference frequencies.

global Ftor Fflex   % Target torsional and flexural frequencies

scale_2 = 1e-0;     % Scaling factor (can be adjusted if needed)

% --- Material parameters (design variables) ---
Modulo  = x(1)*1e10;     % Young's modulus (Pa)
Poisson = x(2)/scale_2;  % Poisson's ratio

% --- Definition of orthotropic elastic properties ---
% Assuming transverse isotropy (or simplified isotropic behavior)
E_X = Modulo; % Young's modulus in X direction
E_Y = Modulo; % Young's modulus in Y direction
E_Z = E_X;    % Young's modulus in Z direction

PR_XY = Poisson; % Poisson's ratio XY
PR_YZ = PR_XY;   % Poisson's ratio YZ
PR_XZ = Poisson; % Poisson's ratio XZ

% Shear moduli (computed from isotropic relationships)
G_XY = E_X/(2*(1+PR_XZ));
G_YZ = G_XY;
G_XZ = E_X/(2*(1+PR_XZ));

% --- Create updated ANSYS input file ---
% Read template journal file
fid = fopen('Prima_trans_iso_BasaltoIrregular1.txt','r');
f = fread(fid,'*char')';
fclose(fid);

% Replace placeholder strings with current material parameters
f = strrep(f,'E_X' , num2str(E_X));
f = strrep(f,'E_Y' , num2str(E_Y));
f = strrep(f,'E_Z' , num2str(E_Z));
f = strrep(f,'PR_XY' , num2str(PR_XY));
f = strrep(f,'PR_YZ' , num2str(PR_YZ));
f = strrep(f,'PR_XZ' , num2str(PR_XZ));
f = strrep(f,'G_XY' , num2str(G_XY));
f = strrep(f,'G_YZ' , num2str(G_YZ));
f = strrep(f,'G_XZ' , num2str(G_XZ));

% Write updated file to be used by ANSYS
fid = fopen('Prima_trans_iso_Final_BasaltoIrregular1.txt','w');
fprintf(fid,'%s',f);
fclose(fid);

%% --- Run ANSYS simulation in batch mode --
% Executes ANSYS using the generated input file
!"C:\Program Files\ANSYS Inc\v192\ansys\bin\winx64\ANSYS192.exe" -b -i Prima_trans_iso_Final_BasaltoIrregular1.txt -o Output.txt

%% --- Import simulation results ---
% Read computed natural frequencies from output file
Freq = importdata('frequencias1.txt');

% --- Objective function definition --
% Weighted error between numerical and reference frequencies
w_flex = 1.0; % Weight for flexural mode
w_tors = 1.0; % Weight for torsional mode

% Error based on squared frequency difference (relative form)
yout(1,1) = w_flex * abs((Freq(1)^2 - Fflex^2)/Fflex^2) + ...
            w_tors * abs((Freq(2)^2 - Ftor^2)/Ftor^2);

end







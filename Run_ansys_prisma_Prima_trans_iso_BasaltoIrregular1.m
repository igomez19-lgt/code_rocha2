
clc; clear;

% Preallocate frequency vector (results from ANSYS)
Freq = zeros(10-6,1);

% --- Clean working directory ---
% Remove previous result files to avoid interference
folder = 'C:\Dados GEO\Artigo Rochas\1.Iteracao2mm';
files = dir(fullfile(folder, '*file*'));

for k = 1:length(files)
    filePath = fullfile(folder, files(k).name);
    delete(filePath);
end

% --- Material parameters (calibrated values) ---
a = [7.89017086847299, 0.257741269457322];

Poisson = a(1,2);          % Poisson's ratio
Modulo  = a(1,1) * 1e10;  % Young's modulus (Pa)

%% --- Update input parameters and run simulation ---
for j = 1:length(Poisson)
    
    % Define elastic properties (assumed isotropic behavior)
    E_X = Modulo;
    E_Y = Modulo;
    E_Z = E_X;

    PR_XY = Poisson(j);
    PR_YZ = PR_XY;
    PR_XZ = Poisson(j);

    % Shear moduli from isotropic relation
    G_XY = E_X / (2 * (1 + PR_XZ));
    G_YZ = G_XY;
    G_XZ = E_X / (2 * (1 + PR_XZ));

    % --- Generate updated ANSYS input file ---
    fid = fopen('Prima_trans_iso_BasaltoIrregular1.txt','r');
    f = fread(fid,'*char')';
    fclose(fid);

    % Replace placeholders with current material properties
    f = strrep(f,'E_X' , num2str(E_X));
    f = strrep(f,'E_Y' , num2str(E_Y));
    f = strrep(f,'E_Z' , num2str(E_Z));
    f = strrep(f,'PR_XY' , num2str(PR_XY));
    f = strrep(f,'PR_YZ' , num2str(PR_YZ));
    f = strrep(f,'PR_XZ' , num2str(PR_XZ));
    f = strrep(f,'G_XY' , num2str(G_XY));
    f = strrep(f,'G_YZ' , num2str(G_YZ));
    f = strrep(f,'G_XZ' , num2str(G_XZ));

    fid = fopen('Prima_trans_iso_Final_BasaltoIrregular1.txt','w');
    fprintf(fid,'%s',f);
    fclose(fid);

    %% --- Run ANSYS modal analysis ---
    tic
    !"C:\Program Files\ANSYS Inc\v192\ansys\bin\winx64\ANSYS192.exe" -b -i Prima_trans_iso_Final_BasaltoIrregular1.txt -o Output.txt
    toc

    %% --- Import simulation results ---
    % Load computed natural frequencies
    load frequencias1.txt
    Freq(:,j) = frequencias1;

end




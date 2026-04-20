
clc; clear;

% Mesh_s_j=[0.009 0.0092 0.0094 0.0095 0.0097 0.0099 0.01];
Freq=zeros(10-6,1);

folder = 'C:\Dados GEO\Artigo Rochas\1.Iteracao2mm'; % Substitua pelo caminho da sua pasta

% Procura todos os arquivos com "file" no nome
files = dir(fullfile(folder, '*file*'));

% Loop para deletar os arquivos encontrados
for k = 1:length(files)
    filePath = fullfile(folder, files(k).name); % Caminho completo do arquivo
    delete(filePath); % Apaga o arquivo
%     fprintf('Arquivo apagado: %s\n', filePath);
end

a=[7.89017086847299,0.257741269457322];
% [8.67969519044077,0.216600343571348]
Poisson=a(1,2);
Modulo=a(1,1)*1e10;

%% Changing the input parameters
for j=1:length(Poisson)
    
E_X =Modulo; %Var1
E_Y=Modulo;  %Var2
E_Z=E_X;   
PR_XY=Poisson(j);   %Var3
PR_YZ=PR_XY; %Var4 
PR_XZ=Poisson(j);   
G_XY=E_X/(2*(1+PR_XZ));	 %Var5
G_YZ=G_XY;	
G_XZ=E_X/(2*(1+PR_XZ));	
 
% creating new journal file
fid  = fopen('Prima_trans_iso_BasaltoIrregular1.txt','r');
f = fread(fid,'*char')';
fclose(fid);
f = strrep(f,'E_X' , num2str(E_X));
f = strrep(f,'E_Y' , num2str(E_Y));
f = strrep(f,'E_Z' , num2str(E_Z));
f = strrep(f,'PR_XY' , num2str(PR_XY));
f = strrep(f,'PR_YZ' , num2str(PR_YZ));
f = strrep(f,'PR_XZ' , num2str(PR_XZ));
f = strrep(f,'G_XY' , num2str(G_XY));
f = strrep(f,'G_YZ' , num2str(G_YZ));
f = strrep(f,'G_XZ' , num2str(G_XZ));

fid  = fopen('Prima_trans_iso_Final_BasaltoIrregular1.txt','w');
fprintf(fid,'%s',f);
fclose(fid);

%% Calculations in ansys with input parameters
% system('C:\"Program Files"\"ANSYS Inc"\v192\Framework\bin\Win64\runwb2.exe -B -R file.db');
tic
!"C:\Program Files\ANSYS Inc\v192\ansys\bin\winx64\ANSYS192.exe" -b -i Prima_trans_iso_Final_BasaltoIrregular1.txt -o Output.txt
toc
%% saving the output parameter
load frequencias1.txt

Freq(:,j)=frequencias1;
end




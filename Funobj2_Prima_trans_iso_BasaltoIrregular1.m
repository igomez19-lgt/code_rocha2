

function yout=Funobj2_Prima_trans_iso_BasaltoIrregular1(x)

global Ftor Fflex

scale_2=1e-0;

Modulo = x(1)*1e10;
Poisson = x(2)/scale_2;
 
E_X =Modulo; %Var1
E_Y=Modulo;  %Var2
E_Z=E_X;   
PR_XY=Poisson;   %Var3
PR_YZ=PR_XY; %Var4 
PR_XZ=Poisson;   
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
% system('C:\"Program Files"\"ANSYS Inc"\v195\Framework\bin\Win64\runwb2.exe -B -R file.db');
% tic
!"C:\Program Files\ANSYS Inc\v192\ansys\bin\winx64\ANSYS192.exe" -b -i Prima_trans_iso_Final_BasaltoIrregular1.txt -o Output.txt
% toc
%% saving the output parameter

Freq=importdata('frequencias1.txt');
% yout(1,1)=log(Freq(1)/5131.17216607617);
% yout(2,1)=log(Freq(3)/5450.80009404977);

w_flex = 1.0;
w_tors = 1.0;

yout(1,1) = w_flex*abs((Freq(1)^2 - Fflex^2)/Fflex^2)+w_tors*abs((Freq(2)^2 - Ftor^2)/Ftor^2);


end







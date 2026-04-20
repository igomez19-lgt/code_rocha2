clear

global Ftor Fflex

Fflex=8226.6; %Frequencia flexional 
Ftor=10007.8; %Frequencia torsional

folder = 'C:\Dados GEO\Artigo Rochas\1.Iteracao2mm'; % Substitua pelo caminho da sua pasta
% Procura todos os arquivos com "file" no nome
files = dir(fullfile(folder, '*file*'));

% Loop para deletar os arquivos encontrados
for k = 1:length(files)
    filePath = fullfile(folder, files(k).name); % Caminho completo do arquivo
    delete(filePath); % Apaga o arquivo
%     fprintf('Arquivo apagado: %s\n', filePath);
end

% xo(1)=4e10*rand(1);
% xo(2)=rand(1)*0.3;
% options=optimset('Display', 'on');
% params_fit=fminsearch(@Funobj,xo,options);

nvar=2;
% options = optimset('Display','iter-detailed');
% options.MaxIter=500;
% options.TolX=1e-1;
% options.TolFun=1e-1;
% options.DiffMaxChange=0.01;
% options.DiffMinChange=1e-8;
% % options.ScaleProblem='Jacobian';
% options.Algorithm={'levenberg-marquardt',0.05};
% oldoptions = optimoptions(@lsqnonlin, 'StepTolerance', 1e-10);
% options = optimoptions(oldoptions, 'OptimalityTolerance', 1e-12); % Ajuste para tolerância menor
% options = optimoptions('lsqnonlin', 'FunctionTolerance', 1e-8); % Ajuste para uma tolerância menor
% options = optimoptions('lsqnonlin', 'Algorithm', 'levenberg-marquardt');
% options = optimoptions('lsqnonlin', 'MaxIterations', 50);
% 

% options.Algorithm='trust-region-reflective';
%options = optimset('Algorithm','active-set');
%'active-set', 'trust-region-reflective', 'interior-point', 'levenberg-marquardt', 'trust-region-dogleg', or
% 'lm-line-search'.
%options = optimset('Algorithm','trust-region-reflective');
%options = optimset('Algorithm','interior-point');
% options.MaxFunEvals=500;
% options = optimoptions('lsqnonlin',...
%     'Display','iter-detailed',...
%     'MaxIterations', 500, ...        % Número máximo de iterações
%     'StepTolerance', 1e-10, ...       % Tolerância para variação no tamanho do passo (TolX)
%     'FunctionTolerance', 1e-8,...
%  'OptimalityTolerance', 1e-12,...   % Tolerância para variação na função (TolFun)
%      'Algorithm', 'trust-region-reflective');      

scale_2=1e-0;

xo(1,1)=8;
xo(2,1)=0.23*scale_2;
lb=[7 0.1*scale_2];
ub=[9 0.4*scale_2];

% val_inicial = Funobj(xo);
% perturbacao = [0 1e-6]';
% gradiente_aproximado = (Funobj(xo + perturbacao) - val_inicial) / perturbacao(2);
% disp(gradiente_aproximado);

% gradiente_inicial = gradient(Funobj(xo));
% disp(gradiente_inicial);

options = optimset('Display','iter','PlotFcns',@optimplotfval);

[x,fval,exitflag,output] = fminsearch(@Funobj2_Prima_trans_iso_BasaltoIrregular1,xo,options);

% [xk,resnorm,residual,exitflag,output] = lsqnonlin(@Funobj2_Prima_trans_iso_BasaltoIrregular1,xo,lb,ub,options);
% xk=[xk(1) xk(2)/scale_2];
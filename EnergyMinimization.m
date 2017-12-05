%% energy minimization dehazing
% I, input image
% A, atmospheric color, can be set, or detected based on the method of He

% J, haze removal result
% T, transmission map
% A, atmospheric color
% Cache, Intermediate data 
function [ J, T, A, Cache ] = EnergyMinimization( I, A )

    Cache = cell(3,1);
    
    %% atmospheric color estimate
    fprintf('estimate atmospheric color...\n');
    if ~exist('A','var')
        A = get_A(I);
    end
    Iw = get_whiteI(I, A);Iw(Iw>1)=1;Iw(Iw<0)=0;

    %% solve initial T, alpha-exphansion
    fprintf('estimate initial transmission map...\n');
    label_num = 32;
    label = alphaExpansion( Iw, label_num );
    T_initial = 1-(label-1)/label_num; 
    
    %% regularization
    fprintf('regularization...\n');
    T_reg = regularization(T_initial,Iw,0.02);
    
    %% brighter
    haze_factor = 1.1;
    gamma = 1;  % <-- reduce this, if you want the result be brighter    
    T = (T_reg + (haze_factor-1) )/haze_factor;
    fprintf('dehazing...\n');

    J1 = dehaze(I,T,A);
    J = J1;
    J(J>0)=J(J>0).^gamma;
    
    %% Intermediate data save
    Cache{1} = T_initial;
    Cache{2} = T_reg;
    Cache{3} = J1;

end


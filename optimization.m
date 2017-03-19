%% SETUP

% Set resolution of optimization for incremental thickness
RES = 100;

% Set resolution of varying the design parameters for sensitivity analysis
RES_sensitivity = 10;

% Material properties
% Density of lining material [kg/m^3]
% Area of the suitcase face [m^2], 
% Young's Modulus of the lining material and shell [kPa]
% Thickness of shell [m]
AREA = 0.76*0.51;
DENSITY = 32.84;
YOUNGS_MOD_L = 27.578;
DAMPING_RATIO_L = 0.096;
YOUNGS_MOD_S = 2.39e6;
TH_S = 0.025;

% Constraints on thickness of material lining [m]
min_th = 0;
max_th = 0.014;
dth = (max_th - min_th)/RES;

% Starting value of lining thickness 
% Update function will systematically decrease the thickness
th = max_th; 

% %% Create some "experimental data"
% % not sure if this is necessary
% expTime = 0:0.01:10;
% expY = exp(-expTime) + 0.02*randn(size(expTime));
% plot(expTime, expY)

% Set up optimization

% ODE Information
t0 = 0;
tf = 10;
tspan = [t0 tf];
y0 = zeros(3,1);

% Starting values for the variables, corresponding to the lining
% All these values depend on the thickness of the lining
m_l = 0.17;
k_l = YOUNGS_MOD_S*AREA/th;
b_l = DAMPING_RATIO_L*2*sqrt(k_l*m_l);

% Selected initial values of constants for the shell and contents
% These values will be varied during mathematical sensitivity analysis
m_s = 6;
m_c = 34.5;
k_s = YOUNGS_MOD_S*AREA/TH_S;
b_s = 0; % Assume no damping in the shell material

% Initial conditions for y is the input force on the system
F_i = (m_s + m_l + m_c)*9.81;

%% ODE SOLVER

[t, y] = ode45(@suitcase (updateParam), tspan,y0,options,m_s,k_s,b_s,m_l,k_l,b_l,m_c,F_i);
p_c = deval(y(7), t); % Evaluate the momentum of contents over time

myObjective = @(x) objFcn(x,t,p_c,tSpan,y0);

lb = 0;
ub = 5;

bestc = lsqnonlin(myObjective, c0, lb, ub);

%% Plot best result
ODE_Sol = ode45(@(t,z)updateStates(t,z,bestc), tSpan, z0);
bestY = deval(ODE_Sol, expTime);

plot(expTime, bestY, '-g')
legend('Exp Data','Initial Param','Best Param');
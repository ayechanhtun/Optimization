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

% Minor calculations
m_s = AREA * TH_S  %Mass of shell


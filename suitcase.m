function dydt = suitcase(t,y,m_s,k_s,b_s,m_l,k_l,b_l,m_c,F_i)

dydt = zeros(5,1);

% % Variables
% % Constants for the shell, lining, and contents
% m_s = 3;
% k_s = 0;
% b_s = 0;
% m_l = 1;
% k_l = 0;
% b_l = 0;
% m_c = 20;

% Constants for the shell
qs = 0;
ps = 144;

% % initial conditions of y
% F_i = 150;

dydt(1) = F_i - k_s*qs - b_s*((1/m_s)*ps-(1/m_l)*y(1));
dydt(2) = k_s*y(1) + k_s*((1/m_s)*ps-(1/m_l)*y(1)) - k_l*y(2) - b_l*((1/m_l)*y(1)-(1/mc)*y(3));
dydt(3) = k_l*y(2) + b_l*((1/m_l)*y(1)-(1/mc)*y(3));


% dydt = zeros(5,1);
% 
% % State equations describing the double mass-spring-damper system model
% dydt(1) = F_i - k_s*y(1) - b_s*y(2);
% dydt(2) = (1/m_s)*y(3) - (1/m_l)*y(4);
% dydt(3) = k_s*y(1) + k_s*y(2) - k_l*y(5) - b_l*y(6);
% dydt(4) = (1/m_l)*y(4) - (1/m_c)*y(7);
% dydt(5) = k_l*y(5) + b_l*y(6);



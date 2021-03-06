function f = suitcaseobjective(th,m_s,k_s,b_s,m_l,k_l,b_l,m_c,F_i,qs,ps,tspan)
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here

y0 = [0 0 0]; % initial values for p3,q11,p13

sol = ode15s(@(t,y) suitcase(t,y,m_s,k_s,b_s,m_l,k_l,b_l,m_c,F_i,qs,ps), tspan, y0);

% Find the time t when y_2
zerofnd = fzero(@(r)deval(sol,r,2),[sol.x(2),sol.x(end)]);

% Find the momentum of the contents at that time
f = deval(sol,zerofnd,1);

f = sol;

end


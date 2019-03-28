% It calculates ODE using Runge-Kutta 4th order method
% Author Ido Schwartz
format long
clc;                                               % Clears the screen
clear all;

h=(1/64);                                             % step size
x = 0:h:1;                                         % Calculates upto y(1)
y = zeros(0,length(x)); 
y(1) = 1;                                          % initial condition
F_xy = @(t,r) exp(t);                    % change the function as you desire

for i=1:(length(x)-1)                              % calculation loop
    k_1 = F_xy(x(i),y(i));
    k_2 = F_xy(x(i)+0.5*h,y(i)+0.5*h*k_1);
    k_3 = F_xy((x(i)+0.5*h),(y(i)+0.5*h*k_2));
    k_4 = F_xy((x(i)+h),(y(i)+k_3*h));

   y(i+1) = y(i) + (1/6)*(k_1+2*k_2+2*k_3+k_4)*h;  % main equation
   
end

p= polyfit(x,y, 8)

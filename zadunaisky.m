clc;                                               % Clears the screen
clear all;


format long


h=(1/8);                                             % step size
x = 0:h:1;                                         % Calculates upto y(1)
y = zeros(0,length(x)); 
y(1) = 1;                                          % initial condition
F_xy = @(t,r) y;                    % change the function as you desire


for i=1:(length(x))                              % calculation loop
    k_1 = F_xy(x(i),y(i));
    k_2 = F_xy(x(i)+0.5*h,y(i)+0.5*h*k_1);
    k_3 = F_xy((x(i)+0.5*h),(y(i)+0.5*h*k_2));
    k_4 = F_xy((x(i)+h),(y(i)+k_3*h));

   y(i+1) = y(i) + (1/6)*(k_1+2*k_2+2*k_3+k_4)*h;  % main equation
  
end
y(i)
scatter(8, exp(1)-y(length(y)));
hold on;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


h=(1/8);
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

p= polyfit(x,y, 8);
syms s;
   eq= p(1)*s^8+p(2)*s^7+p(3)*s^6+p(4)*s^5+p(5)*s^4+p(6)*s^3+p(7)*s^2+p(8)*s+p(9);
   k= diff(eq,s);
   eq= subs(eq, s, x(length(x)));
   k= subs(k,s,x(length(x)));
  correctedY=y(length(y))-eq+k;
  %y(i+1) = correctedY;

scatter(8, exp(1)-correctedY, 'd');
drawnow;
function [y]=VSVO45(fun,a,b,tau) 

format 'long';
%t keeps track of where we are in the problem
t=a; 
%These two lines may seem frivilous, but I need a constant y0 and changing
%y
y0=feval(fun, a);
y=y0;
%yF is useful for comparing to y0
yF=feval(fun, b);
%the variable name RK45 is a holdover, but this is the non-absolute value 
%of the current error at each step
RK45est=0;
%sumEst is the total error estimate of all previous steps
sumEst=tau;
%goodStep tells if we accepted the last step or not
goodStep=false;
%best starting stepsize for RK45
h=tau^(1/5)/4;

%test
goodstepCount=1;
badstepCount=1;

%set all the values for the failed steps
%badk1=0; badk2=0;badk3=0; badk4=0; badk5=0; badk6=0;
%baderr=tau;

%onebadstep=false;
%the following vector comes from the RK45 Butcher Tableau
a7=[35/384 0 500/1113 125/192 -2187/6784 11/84]'; 
%error vector of the RK45 Butcher Tableau
e=[71/57600 -1/40 -71/16695 71/1920 -17253/339200 22/525]';

%k1 is needed once before looping, it is reset near lines 64 || 68
k1=y0; 

while t < b 
if t+h > b; h=b-t;end% dont overstep the problem
%K values of RK45
k3=feval(fun,t+3*h/10); 
k4=feval(fun,t+4*h/5);
k5=feval(fun,t+8*h/9);
%k6=feval(fun, t+h); this is in the if statement because we already know
%the value at y(b) so no need to call the fn again
if (t+h)==b
    k6=yF;
else
    k6=feval(fun,t+h); 
end
%final value, but we're going to make sure we like it before setting it to
%our actual y value
yt=y+h*(a7(1)*k1+a7(3)*k3+a7(4)*k4+a7(5)*k5+a7(6)*k6); 
k2=k6;


%error of RK45
if goodStep==true %if we liked the last step, we will add it to the sumEst
    if (yF<y0)
       sumEst=sumEst+RK45est;
       %sumEst=tau;
    else
        sumEst=sumEst-RK45est;
        %sumEst=tau;
    end
end
%error based on buther tableau
RK45est=(h*(e(1)*k1+e(2)*k2+e(3)*k3+e(4)*k4+e(5)*k5+e(6)*k6));

est=abs(RK45est);
    
    

%this gets a little complex, if the error is < tau we're good to go, but if
%the error added to all previous erros is less than tau we are also safe to
%continue, this allows slightly fewer steps before success generaly ~1%
%more efficent
if est < tau || ((yF<y0 && abs(sumEst+RK45est) < .5*tau) || (yF>y0 && abs(sumEst-RK45est) < .5*tau))
    t=t+h; 
    k1=k2;
    y=yt; 

    %take stepsize based on number of successful steps in a row. this hurts
    %for cos and tan, but is very helpful for sin, e^x, x^c
    goodstepCount=goodstepCount+1;
    badstepCount=1;
     
    h=h*goodstepCount;

    goodStep=true;
    
 

%assuming we didn't like the last step
else 
    
    %take stepsize based on number of failed steps in a row. this hurts for
    %cos and tan, but is very helpful for sin, e^x, x^c
    badstepCount=badstepCount+1;
    goodstepCount=1;
    
%    if badstepCount==2
%        h=h/2;
%    else
%        h=h/3;
%    end
    h=h/badstepCount;
    goodStep=false;
    
end
end 
%now that we've done all the work the integral is easy
y=y-y0;
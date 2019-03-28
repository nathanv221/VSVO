%matlabQuadratureMethod,quad.m
function R = quad(f,a,b,tau)
n=1;
RES=0;
x_nMinusOne=a;
h=.00000001;
sigma=.09;
answer=0;
go=true;
while go
    if x_nMinusOne == b
        go = false;
    end
    x_n = x_nMinusOne+h;
    if x_n>b
        h=b-x_nMinusOne;
        x_n=b;
    end
    M_n=h*f((x_nMinusOne+x_n)/2);
    T_n=(h/2)*(f(x_nMinusOne)+f(x_n));
    e_est= abs((T_n-M_n)/3);
    e_des = abs((h*tau)/(b-a));
    
    h= sigma *h* sqrt(e_des/e_est);
    
    if e_est < e_des
        n=n+1;
        RES=RES+M_n;
    end
    answer=answer+(M_n);
    x_nMinusOne=x_n;
end
R = answer;
end

    
        
      

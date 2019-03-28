%eulers method
for s=3:15
    y=1;
    h=2^(-s);
    xFinal=1;
    x=0;
    while (x<xFinal)
        y=y+h*(y);
        x=x+h;
    end
    scatter(h,y-exp(1));
    hold on;
end
    drawnow;
    
    %trapezodial rule
for s=3:15
    y=1;
    h=2^(-s);

    n=1/h;
    for i = 1:n-1
        y=y+h*((y+(y+h))/2);

    end
    scatter(h,y-exp(1),20,'k','s');
    hold on;
end
    drawnow;
    
        %simpsons rule
for s=3:15
    h=2^(-s);
    a=1.9;
    N=1/h;
    I=0;
    for n=1:(N/2-1)
        b=h*2+a;
        I=I+(h/3)*(a*4*((a+b)/2)+b);
    end
    scatter(h,I-exp(1),30,'black','filled');
    hold on;
end
    drawnow;
    
    %RungeKutta method
for s=3:15
    y=1;
    h=2^(-s);
    x=0;
    while x<1
        K1=y;
        K2=y+(h/2)*K1;
        K3=y+(h/2)*K2;
        K4=y+h*K3;
        y=y+h/6*(K1+2*K2+2*K3+K4);
        x=x+h;
    end
       scatter(h,y-exp(1),'k','d');
    hold on;
end
    drawnow;    
    
    
    
    
    
    
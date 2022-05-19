function int = exactfh(T,d)

rho = @(x,y,T,d) exp((-x.^2-y.^2)/(4*T))./((4*pi*T)^(d/2)); %%This is exact solution

x = linspace(-100,100,10000);

int = 0;
for j =1:9999
    int = int + (rho((x(j+1)+x(j))/2)*log(rho((x(j+1)+x(j))/2)))*(x(j+1)-x(j));
end

end
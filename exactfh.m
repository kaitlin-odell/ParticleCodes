function int = exactfh(t)

rho = @(x) exp(-x.^2/(4*t))./sqrt(4*pi*t); %%This is exact solution for heat equation

x = linspace(-100,100,10000);

int = 0;
for j =1:9999
    int = int + (rho((x(j+1)+x(j))/2)*log(rho((x(j+1)+x(j))/2)))*(x(j+1)-x(j));
end

end
function y = thm1(xn, xn1, tau, env_name)
[N,d] = size(x);

fhn = Fh(xn, env_name);
fhn1 = Fh(xn1, env_name);

XY = x*x';
x2= sum(x.^2, 2);
X2e = repmat(x2, 1, n);

H = (X2e + X2e' - 2*XY);

obj = 0;

end
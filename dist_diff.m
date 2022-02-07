%Pick one toy environment to play
    %Different name corresponds to different V(x) in the Fokker-Plank equation
    %The definition of V(x) can be found in environment.py
env_name = 'double_banana';
%env_name = 'banana';
%env_name = 'sine';
%env_name = 'star';
%env_name = 'wave';

n_particles = [4 16 64 256 1028 4112];  %number of particles (can be adjusted as desired)
%n_particles = 256;
d = 2;            %dimension of the problem
outer_iter = 100;    %number of outer iterations (can be adjusted as desired)

%%Compute the target distribution
%%For Star distribution
%y = trainer(env_name, 8000, outer_iter);
%int2 = sum(f(y(:,1),y(:,2)))/8000;


%%For sine distribution
%rho_star = @(x,y) exp((-1/2)*((y - sin(pi*x/2))/0.4)^2);


%%For banana distribution
%rho_star = @(x,y) exp(-x^2/2 - (1/2)*(10*y + 3*x^2 - 3)^2);


%%For double banana distribution
rho_star = @(x,y) exp(-2*((x^2 + y^2) -3)^2 + log(exp(-2*(x-2)^2) + exp(-2*(y+2)^2)));

% f = @(x,y) exp((-x.^2 - y.^2)/10);
f = @(x,y) 0.3*x.^4 + 0.5*y.^4;

%Use Midpoint Method to estimate rho_star*f integral
n = 2000; %number of subintervals in the x direction
m = 2000; %number of subintervals in the y direction
dx = (20)/n;
dy = (20)/m;
int2 = 0;
for k = 1:n
    for j = 1:m
        int2 = int2 + rho_star((-10 + k*dx)/2, (-10 + j*dy)/2)*f((-10 + k*dx)/2, (-10 + j*dy)/2)*dx*dy;
    end
end

% for i = 1:6
%     int1 = 0;
%     x_evi = trainer(env_name, n_particles(i), outer_iter);
%     rho = @(x) exp(-norm(x - x_evi,2)^2/(2*n_particles(i)*h^2))/((2*pi*h^2)^(d/2));
%     for j=1:n
%         for k=1:m
%             int1 = int1 + rho([(-2.5 + k*dx)/2, (-2.5 + j*dy)/2])*f((-2.5 + k*dx)/2, (-2.5 + j*dy)/2)*dx*dy;
%         end
%     end
%     int(i) = sum(int1) - int2;
% end


int = zeros(6,1);
for i = 1:6
    %%calculates the approximated particles%%
    x_evi = trainer(env_name, n_particles(i), outer_iter);

    %%Calculate int f*(rho - rho_star)
    int(i) = abs(sum(f(x_evi(:,1),x_evi(:,2))/n_particles(i)) - int2);
end

for i = 2:6
    cov(i) = (int(i-1)/int(i));
end

t = table(n_particles', int, cov');

plot(n_particles,int)
xlim([0,4112])
xlabel('Number of Particles')
ylabel('\int_{\Omega} f(x)(\rho(x) - \rho_\ast(x)) dx')
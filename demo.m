%Pick one toy environment to play
    %Different name corresponds to different V(x) in the Fokker-Plank equation
    %The definition of V(x) can be found in environment.py
%env_name = 'double_banana';
env_name = 'banana';
%env_name = 'sine';
%env_name = 'star';

n_particles = 150;  %number of particles
dim = 2;            %dimension of the problem
outer_iter = 100;

x_evi = trainer(env_name, n_particles, outer_iter);


%%Compute the un-normalized target distribution, only for the visualization
ngrid = 500;
%set the line space carefully to the region of your figure
x = linspace(-2, 2, ngrid);  %region of x  For star: change to (-4, 4)
y = linspace(-2, 2, ngrid);  %region of y  For star, change to (-4, 4)
[X, Y] = meshgrid(x, y);
XY = [reshape(X,[1,500^2]); reshape(Y,[1, 500^2])];

if strcmp(env_name,'star')
    logp = star(100, 5,XY');  %star gaussian mixture example
elseif strcmp(env_name, 'sine')
    logp = sine(1, 0.003,XY');  %unimodal sine shape example
elseif strcmp(env_name, 'double_banana')
    logp = double_banana(0.0, 100.0, 1.0, 0.09, log(30),XY');  %bimodal double banana example
elseif strcmp(env_name,'banana')
    logp = banana(XY');
end

Z = exp(logp);
Z = reshape(Z, [500,500]);

%%%Plot the target distribution and evi particles%%%
hold on
contourf(X,Y,Z)
scatter(x_evi(:,1),x_evi(:,2),'*')
xlim([-2,2])
ylim([-2,2])
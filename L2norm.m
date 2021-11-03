clear;
%Pick one toy environment to play
    %Different name corresponds to different V(x) in the Fokker-Plank equation
    %The definition of V(x) can be found in environment.py
%env_name = 'double_banana';
%env_name = 'banana';
%env_name = 'sine';
env_name = 'star';

n_particles = 50;  %number of particles
dim = 2;            %dimension of the problem
outer_iter = 50;

%%Compute points in the un-normalized target distribution for MMD calculation
M = 50;
y = sample_star(100,5,M);

x_evi = trainer(env_name, n_particles, outer_iter);
L2 = norm(y-x_evi);

%%%Plot the target distribution and evi particles%%%
% figure(1);
% hold on
% plot(x,L2)
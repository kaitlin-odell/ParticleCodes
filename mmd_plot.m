clear;
%Pick one toy environment to play
    %Different name corresponds to different V(x) in the Fokker-Plank equation
    %The definition of V(x) can be found in environment.py
%env_name = 'double_banana';
%env_name = 'banana';
%env_name = 'sine';
env_name = 'star';

n_particles = 200;  %number of particles
dim = 2;            %dimension of the problem
outer_iter = 1:50;
MMD = zeros(1,200);

%%Compute points in the un-normalized target distribution for MMD calculation
M = 5000;
y = sample_star(100,5,M);

for i = 1:50
    x_evi = trainer(env_name, n_particles, outer_iter(i));
    MMD(i) = mmd(x_evi, y, n_particles, M);
end

%%%Plot the target distribution and evi particles%%%
figure(1);
hold on
plot(x,MMD)
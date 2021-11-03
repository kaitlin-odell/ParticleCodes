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
outer_iter = 1:200;
L2_iter = zeros(1,200);

%%Compute points in the un-normalized target distribution for MMD calculation
y = sample_star(100,5,n_particles);

for i = 1:200
    x_evi = trainer(env_name, n_particles, outer_iter(i));
    L2_iter(i) = norm(y-x_evi,2)/n_particles;
end

%%%Plot the L2 vs number of iterations%%%
figure(1);
hold on
plot(outer_iter,L2_iter)

n_particles = [4 16 64 256 1024 4056]; 
outer_iter = 50;
L2_particles = zeros(1,length(n_particles));

for i = 1:length(n_particles)
    x_evi = trainer(env_name, n_particles(i), outer_iter);
    y = sample_star(100,5,n_particles(i));
    L2_particles(i) = norm(y-x_evi, 2)/n_particles(i);
end

%%%Plot the MMD^2 vs the number of particles%%%
figure(2);
hold on
plot(n_particles,L2_particles)
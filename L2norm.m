clear;
%Pick one toy environment to play
    %Different name corresponds to different V(x) in the Fokker-Plank equation
    %The definition of V(x) can be found in environment.py
%env_name = 'double_banana';
%env_name = 'banana';
%env_name = 'sine';
env_name = 'star';

n_particles = 100;  %number of particles (can be adjusted as desired)
dim = 2;            %dimension of the problem
outer_iter = 1:200; %maximum outer iteration is 200 (can be adjusted as desired)
L2_iter = zeros(1,200);

%%Compute points in the un-normalized target distribution for L2 calculation
y = sample_star(100,5,n_particles);

%%Calculate L2 norm at each iteration%%
for i = 1:200
    x_evi = trainer(env_name, n_particles, outer_iter(i));
    L2_iter(i) = norm(y-x_evi,2)/n_particles;
end

%%%Plot the L2 norm vs number of iterations%%%
figure(1);
hold on
plot(outer_iter,L2_iter)

n_particles = [4 16 64 256 1024 4056]; %number of particles (can be adjusted as desired)
outer_iter = 50;                       %maximum outer iteration is 200 (can be adjusted as desired)
L2_particles = zeros(1,length(n_particles));

%%Calculate L2 norm for each number of particles%%
for i = 1:length(n_particles)
    x_evi = trainer(env_name, n_particles(i), outer_iter);
    y = sample_star(100,5,n_particles(i));
    L2_particles(i) = norm(y-x_evi, 2)/n_particles(i);
end

%%%Plot the L2 norm vs the number of particles%%%
figure(2);
hold on
plot(n_particles,L2_particles)
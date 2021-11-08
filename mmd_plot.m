clear;
%Pick one toy environment to play
    %Different name corresponds to different V(x) in the Fokker-Plank equation
    %The definition of V(x) can be found in the corresponding .m files
%env_name = 'double_banana';
%env_name = 'banana';
%env_name = 'sine';
env_name = 'star';

n_particles = 200;  %number of particles (can be adjusted as desired)
dim = 2;            %dimension of the problem
outer_iter = 1:200; %maximum outer iteration is 200 (can be adjusted as desired)
MMD1 = zeros(1,200);

%%Compute points in the un-normalized target distribution for MMD calculation
M = 5000;
y = sample_star(100,5,M);

%%Calculate MMD^2 at iteration%%
for i = 1:200
    x_evi = trainer(env_name, n_particles, outer_iter(i));
    MMD1(i) = mmd(x_evi, y, n_particles, M);
end

%%%Plot the MMD^2 vs number of iterations%%%
figure(1);
hold on
plot(outer_iter,MMD1)

n_particles = [4 16 64 256 1024 4056]; %number of particles (can be adjusted as desired)
outer_iter = 50;                       %max number of iterations (can be adjusted as desired)
MMD2 = zeros(1,length(n_particles));

%%Calculate the MMD^2 for each number of particles%%
for i = 1:length(n_particles)
    x_evi = trainer(env_name, n_particles(i), outer_iter);
    MMD2(i) = mmd(x_evi, y, n_particles(i), M);
end

%%%Plot the MMD^2 vs the number of particles%%%
figure(2);
hold on
plot(n_particles,MMD2)
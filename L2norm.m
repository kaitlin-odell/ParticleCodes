%Pick one toy environment to play
    %Different name corresponds to different V(x) in the Fokker-Plank equation
    %The definition of V(x) can be found in environment.py
%env_name = 'double_banana';
%env_name = 'banana';
%env_name = 'sine';
env_name = 'star';

n_particles = 100;  %number of particles (can be adjusted as desired)
dim = 2;            %dimension of the problem
outer_iter = 1:500; %maximum outer iteration is 500 (can be adjusted as desired) 
L2_iter = zeros(1,500);

%%Compute points in the un-normalized target distribution for L2 calculation 
y = sample_star(100,5,n_particles); %Change the sample to the environment name

%Calculate L2 norm at each iteration%%
for i = 1:500
    x_evi = trainer(env_name, n_particles, outer_iter(i)); 
    L2_iter(i) = norm(y-x_evi,2)/n_particles;
end

%%%Plot the L2 norm vs number of iterations%%% figure(1); 
hold on
plot(outer_iter,L2_iter) 
xlim([0,500]) 
xlabel('# of Iterations')
ylabel('L2 Norm')

% n_particles = [4 16 64 256 1024 4056]; %number of particles (can be adjusted as desired)
% outer_iter = 100;                  %maximum outer iteration is 100 (can be adjusted as desired)
% L2_particles = zeros(1,length(n_particles));
% conv2 = L2_particles;
% % 
% %%Calculate L2 norm for each number of particles%%
% for i = 1:length(n_particles)
%     x_evi = trainer(env_name, n_particles(i), outer_iter);
%     y = sample_doubbanana(n_particles(i)); %Change the sample to the environment name
%     L2_particles(i) = norm(y-x_evi, 2)/sqrt(n_particles(i));
%     
%     %%Calculate the convergence ratio for number of particles%%
%     if i == 1
%         conv2(i)=0;
%     else
%         conv2(i) = L2_particles(i-1)/L2_particles(i);
%     end
% end
% 
% %%%Plot the L2 norm vs the number of particles%%%
% figure(2);
% hold on
% plot(n_particles,L2_particles)
% xlim([0,4056])
% xlabel('# of Particles')
% ylabel('L2 Norm')
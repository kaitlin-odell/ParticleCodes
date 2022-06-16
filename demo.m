clear;
tic
%% Pick one toy environment to play
    %Different name corresponds to different V(x) in the Fokker-Plank equation
    %The definition of V(x) can be found in environment.py
%env_name = 'double_banana';
%env_name = 'banana';
%env_name = 'sine';
%env_name = 'star';
%env_name = 'wave';
env_name = 'heat';
%env_name = 'linearfp';

n_particles = 64;  %number of particles (can be adjusted as desired)
%n_particles = [16 32 64 128 256 512];
%n_particles = [4 floor(sqrt(32)) floor(sqrt(64)) floor(sqrt(128)) floor(sqrt(256)) floor(sqrt(512))]; 
tau = 1e-2;
%tau = [1e-1 1e-2 1e-3 1e-4 1e-5 1e-6]; %step for implicit euler 
outer_iter = 2/1e-2;
%outer_iter = [4 7 13 25 49 97];    %number of outer iterations (can be adjusted as desired)


%% calculates the approximated particles%%
for i = 1:length(n_particles)
    [x_evi, rho_star, rho_x] = trainer(env_name, n_particles(i), outer_iter, tau);
end

toc


%% Plots the target distribution with the approximated particles
% Compute the un-normalized target distribution, only for the visualization
% ngrid = 500;
% %set the line space carefully to the region of your figure
% x = linspace(-5, 5, ngrid);  %region of x  For star: change to (-4, 4)
% y = linspace(-5, 5, ngrid);  %region of y  For star, change to (-4, 4)
% [X, Y] = meshgrid(x, y);
% XY = [reshape(X,[1,500^2]); reshape(Y,[1, 500^2])];
% 
% if strcmp(env_name,'star')
%     logp = star(100, 5,XY');  %star gaussian mixture example
% elseif strcmp(env_name, 'sine')
%     logp = sine(1, 0.003,XY');  %unimodal sine shape example
% elseif strcmp(env_name, 'double_banana')
%     logp = double_banana(0.0, 100.0, 1.0, 0.09, log(30),XY');  %bimodal double banana example
% elseif strcmp(env_name,'banana')
%     logp = banana(XY');
% elseif strcmp(env_name,'wave')
%     logp = wave(XY');
% elseif strcmp(env_name,'heat')
%     logp = heat(x,.5,1/4);
% end
% 
% Z = exp(logp);
% Z = reshape(Z,[500,500]);
% 
% % Plot the target distribution and evi particles %%
% figure(1);
% hold on
% contourf(X,Y,Z)
% scatter(x_evi(:,1),x_evi(:,2),'*r')
% xlim([-5,5])
% ylim([-5,5])

%% Plot theorem 1 %%
% figure(2);
% plot(1:100,jn)
% ylim([-6,0])

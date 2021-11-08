# ParticleCodes

Codes for a particle based energetic variational inference with different target distributions.

List of main files:
     demo.m: Main file to run different environments, iterations, and number of particles and will also plot the target distribution with approximated particles.
  trainer.m: The outer loop of ParVI method to minimize particle approximations
   evi_im.m: Energetic Variational Inference w/ Implicit Euler using gradient descent to calculate particle approximations
KL_gradxy.m: Calculates the gradient of J_n(x)

List of target distribution files:
       banana.m: Define V(x) in FP for a banana shaped target distribution
double_banana.m: Define V(x) in FP for two banana shaped target distributions
         sine.m: Define V(x) in FP for a unimodal sine target distribution
         star.m: Define V(x) in FP for a gaussian star distribution
         wave.m: Define V(x) in FP for a wave distribution

List of metrics:
mmd_plot.m: Creates an MMD^2 vs iterations and MMD^2 vs particles figures.
  L2norm.m: Creates an L2 norm vs iterations and L2 norm vs particles figures.
 
To run the particle approximation and plotting, use: 

demo.m (Within demo.m you can adjust the env_name, number_particles, and outer_iter as desired.)

To run the metrics, use:

mmd_plot.m (Within mmd_plot.m you can adjust the env_name, max number_particles, and max outer_iter as desired.)
  L2norm.m (Within L2norm.m you can adjust the env_name, max number_particles, and max outer_iter as desired.)


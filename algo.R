######## Task 0 - Set the array job number
slurm_id <- as.integer(Sys.getenv('SLURM_ARRAY_TASK_ID'))

# Import libraries
library(foreach)
library(doParallel)

# Source the functions to run the simulations
source("EpsilonGreedy.R")

######## Task 1 
# Create a variable called 'cores' here to specify the number of cores you want 
# to use. Then, check out the function RegisterDoParallel() to activate them
n_cores <- 5
registerDoParallel(cores = n_cores)

######## Task 2
# Run the simulation

# Parameters of the simulation
n_sims <- 5000 / 10   # Number of simulations
horizon <- 5000  # Horizon of the experiment
p <- 20          # Number of arms

# Set here the number of values
epsilon_values <- c(0.03, 0.01, 0.05, 0.1, 0.15)
epsilon <- epsilon_values[slurm_id]

# This seed ensures reproducibility with the doParallel interface
set.seed(42, kind = "L'Ecuyer-CMRG") 

# Run the simulation in parallel here using the foreach command. 
# Use .combine = 'rbind'. argument to merge the output. 
output <- foreach(i = 1:n_sims, .combine = 'rbind') %dopar% {
  run_simulation(horizon = horizon, p = p, epsilon = epsilon) 
}

######## Task 3
# Calculate the mean regret and save it in an R object 
final_output <- list("epsilon" = epsilon, "result" = colMeans(output))
output_name <- paste0("../Res/EspilonGreedy_", slurm_id, ".rds")
saveRDS(final_output, output_name)

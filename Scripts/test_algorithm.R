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
cores <- 5


######## Task 2
# Run the simulation

# Parameters of the simulation
n_sims <- "xx"    # Number of simulations
horizon <- "xx"  # Horizon of the experiment
p <- "xx"          # Number of arms

# Set here the number of values
epsilon_values <- c(-0.01, 0.01, 0.05, 0.1, 0.15)
epsilon <- "xx"

# This seed ensures reproducibility with the doParallel interface
set.seed(42, kind = "L'Ecuyer-CMRG") 

# Run the simulation in parallel here using the foreach command. 
# Use .combine = 'rbind'. argument to merge the output. Call the object 'output'.

output <- ...
#run_simulation(horizon = horizon, p = p, epsilon = epsilon)

######## Task 3
# Calculate the mean regret and save it in an R object 
final_output <- colMeans(output)
output_name <- ... 
saveRDS(...)



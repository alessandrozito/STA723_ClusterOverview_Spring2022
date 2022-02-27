# Simulate the performance of an epsilon-greedy algorithm
# and find for the best value for epsilon.

## Function to simulate a Dirichlet Distribution
sample_true_probs <- function(p) {
  out <- runif(n = p)
  return(out)
}

# Function to choose the arm. The probability of choosing an arm at random is
# epsilon while 1-epsilon is the prob of choosing the "best"arm, where best
# means "highest estimated prob. of success so far"
choose_arm <- function(mu, epsilon) {
  # Toss a coin
  p <- length(mu)
  change <- runif(1) < epsilon
  if (change) {
    # Select one arm at random
    chosen_arm <- sample(1:p, 1)
  } else {
    # Select the best arm
    chosen_arm <- which.max(mu)
  }
  return(chosen_arm)
}

# Sample the binary reward
get_reward <- function(chosen_arm, true_probs) {
  reward <- 1 * (runif(1) < true_probs[chosen_arm])
  return(reward)
}

# Update estimated success probability
update_success_prob <- function(reward, mu, pulls, chosen_arm) {
  n_pulls <- pulls[chosen_arm]
  new_prob <- (mu[chosen_arm] * n_pulls + reward) / (n_pulls + 1)
  return(new_prob)
}


# Run the simulation
run_simulation <- function(horizon, p, epsilon) {
  # Step 0 - Generate the "true probability" vectors
  true_probs <- sample_true_probs(p)
  best_prob <- max(true_probs)

  # Step 1 - Initialize the quantities
  mu <- rep(0, p)
  pulls <- rep(0, p)
  regrets <- rep(NA, horizon)

  # Step 2 <- run the simulation
  for (t in 1:horizon) {
    # Select the arm
    arm <- choose_arm(mu = mu, epsilon = epsilon)
    # Observe the reward
    reward <- get_reward(chosen_arm = arm, true_probs = true_probs)
    # Update mu
    mu[arm] <- update_success_prob(
      reward = reward, mu = mu, pulls = pulls,
      chosen_arm = arm
    )
    # Update the number of pulls
    pulls[arm] <- pulls[arm] + 1
    # Compute the per-period regret at time t
    regrets[t] <- best_prob - true_probs[arm]
  }
  return(regrets)
}

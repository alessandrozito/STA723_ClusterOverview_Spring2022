library(magrittr)
library(tidyr)
library(dplyr)

# Files to aggregate 
setwd('../Res/')
f <- list.files()
f <- f[stringr::str_detect(f, '.rds')]

out <- matrix(nrow = length(f), ncol = length(readRDS(f[1])$result))
eps_vals <- numeric(length(f))

# Read into memory
for (i in seq_along(f)) {
  out[i, ] <- readRDS(f[i])$result
  eps_vals[i] <- readRDS(f[i])$epsilon
}

out %<>% 
  t() %>%
  as.data.frame() %>%
	mutate(Time = seq_len(nrow(.))) %>%
  `colnames<-`(c(eps_vals, 'Time')) %>%
  pivot_longer(cols = -Time, values_to = 'Regret', names_to = 'Epsilon')

saveRDS(out, '../bandits_output.rds')

# Delete individual simulation files (dangerous!)

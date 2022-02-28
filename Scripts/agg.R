# Files to aggregate 
f <- list.files('Res/')
f <- f[stringr::str_detect('.rds')]

out <- ...

# Read into memory
for (i in seq_along(f)) {
  next
}

saveRDS(out, 'bandits_output.rds')

# Delete individual simulation files (dangerous!)
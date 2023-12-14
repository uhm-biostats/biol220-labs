## Simulated data for RoLE workshop

MESS-SIMOUT.csv.gz - 3000 simulations total, with 1000 simulations under each
assembly model of neutral, competition, and filtering.

params-Cyprus-\*-.txt - Params files used to generate thes simulations.

## Mystery simulations
Mystery-SIMOUT.csv - The full mystery data simulations, concatenated and shuffled

Mystery-data.csv - Just the local_S and *_h* Hill numbers per simulation
Mystery-key.csv - J, coltime, assembly_model, ecological_strength

```
## Mystery sims
mystery_data = MESS$load_local_sims("Mystery-SIMOUT.csv")[[1]]
mystery_key = mystery_data[, 17:20]
print(mystery_key)
write.csv(x=mystery_key, file="Mystery-key.csv")

mystery_dat = mystery_data[, 34:43]
mystery_dat
write.csv(x=mystery_dat, file="Mystery-data.csv")
```

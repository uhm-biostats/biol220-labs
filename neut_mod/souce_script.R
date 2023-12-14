#### Source code ####

source("https://raw.githubusercontent.com/role-model/process-models-workshop/main/neut_mod/neutral_mod.R")

#### Set seed #### 

set.seed(1989)

#### Play with parameters ####

toy_sim <- untb(Jm = 10000, Sm = 1000, J = 100, m =.01, nu = .01, niter = 1000)

toy_summary <- untb_hill(toy_sim)

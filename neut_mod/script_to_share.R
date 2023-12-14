### Play the game here

#Jm - leaving blank for this simple scenario 
# because our metacomm species have equal abundance

#### Parameters ####

J <- 36
Sm <- 7

# 1/4 chance of immigration
m <- 0.25

# Chance of speciation
u <- 0.1 


# Number of rounds to run
niter <- 100

#### Initialization #### 

meta_comm <- rep(1,Sm)


# Choosing which species starts out as the species in the local community
imm_sp <- sample(1:Sm,1,prob=meta_comm)
imm_sp

Smax <- Sm

# Populating the local community with the founding species
local_comm <- rep(imm_sp,J)
local_comm

for(i in 1:niter) {
  # Choosing the index of the indiv to die
  idead <- sample(1:J,1)
  
  # Decide whether immigration or birth occurs
  imm_roll <- runif(1)
  
  if(imm_roll < m){
    
    # If immigration...
    # Choose a parent from the metacommunity
    parent_sp <- sample(1:Sm,1,prob=meta_comm)
  } else{
    
    # If birth...
    # Choose a parent from the local community
    parent_indv <- sample(1:J,1)
    parent_sp <- local_comm[parent_indv]
  }
  
  # Decide if there's speciation
  sp_roll <- runif(1)
  if(sp_roll < u){
    # If speciation..
    # Update Smax and change the species for the new indiv.
    parent_sp <- Smax + 1
    Smax <- Smax + 1
  }
  
  # Updating the local community with the new individual 
  local_comm[idead] <- parent_sp
  
  
}

local_comm



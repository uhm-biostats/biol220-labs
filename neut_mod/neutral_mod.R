#### Function to run simple neutral sims ####
# RMD copying and modifying from AJR's code in ml_neutral_test.qmd 


untb <- function(Jm, # num individuals in the metacomm
                 Sm, # num spp in the metacomm
                 J,  # num individuals in local comm
                 m,  # immigration prob
                 nu, # speciation prob
                 niter) { # number of time steps
  
  
  #### Setup ####
  
  # We need a metacommunity.
  # Logseries metaSAD - this is important because of the weighting for the odds of which species does the immigrating. 
  # For our purposes we can use roleR.
  # this is an sad stored as relative abundances. 
  # meta_species_ids <- roleR:::.lseriesFromSN(Sm, Jm)
  
   meta_species_ids <- rep(1/Sm, times = Sm)
  
  # And a local community
  # local_species_ids is a vector to keep track of the species ID of each individual in the local community.
  # We initialize it with all individuals being of the same species.
  # We decide which species that is by picking at random from all the species in the metacommunity,
  # with probability weighted according to the relative abundances in the metacommunity.
  local_species_ids <- vector(mode = "integer", length = J)
  local_species_ids[1:J] <- sample(Sm, 1, prob = meta_species_ids)
  
  # Finally, we need a counter to keep track of species IDs.
  # As we add new species through speciation, we'll increment this ID to make sure we're getting a unique species identifier.
  Smax <- Sm
  
  #### Playing the game ####
  
  for(i in 1:niter) {
    
    # In each timestep, first we choose an individual from the local community to die.
    idead <- sample(J, 1)
    
    # Then we need to find out the species ID for the individual who will replace the dead individual.
    
    # First, find out if immigration will occur.
    s <- runif(1) # This will return a random number between 0 and 1. Like rolling a die, with probability 1/m s will be < m. 
    if(s < m) { # If this occurs, immigration occurs. The dead individual will be replaced by an individual drawn at random from the metacommunity.
      newParent <- sample(Sm, 1, prob = meta_species_ids) # Choose the species ID for the replacement individual.
    } else { # If immigration does NOT occur, the new individual will be an offspring of one of the other individuals in the local community. We decide who the parent is by drawing at random from the local community.
      # Before we pick the parent species, we need to remove the individual who dies. 
      possible_parents <- local_species_ids[-idead]
      newParent <- sample(possible_parents, 1)
    }
    
    # Now that we have the parent individual, we need to find out if a speciation event occurs.
    s <- runif(1) # The same roll-of-the-dice mechanism as above
    if(s < nu) {
      # If speciation occurs, we need to assign it a never-before-seen species identity and add a new species to our ever-recorded-species pool!
      Smax <- Smax + 1 # increment max sp ID
      newSpId <- Smax
    } else {
      
      newSpId <- newParent

    }
    
    # Finally, we re-assign the species ID for the individual who dies, to the new species ID. 
    local_species_ids[idead] <- newSpId
  }
  
  # At the end of the simulation, tally up how many individuals we have of each species.
  local_species_abundances <- tabulate(local_species_ids)
  local_species_abundances <- local_species_abundances[ local_species_abundances > 0]
  
  return(local_species_abundances)
}

#### Function to summarize neutral sims ####

untb_hill <- function(local_species_abundances) {
  
  hill0 <- hillR::hill_taxa(local_species_abundances, q = 0)
  hill1 <- hillR::hill_taxa(local_species_abundances, q = 1)
  hill2 <- hillR::hill_taxa(local_species_abundances, q = 2)
  
  return(data.frame(
    hill0 = hill0,
    hill1 = hill1,
    hill2 = hill2
  ))
  
}


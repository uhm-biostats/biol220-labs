#### Source code ####

source(here::here("neut_mod", "neutral_mod.R"))

#### Set seed #### 

set.seed(1989)

#### Play with parameters ####

toy_sim <- untb(Jm = 10000, Sm = 1000, J = 100, m =.01, nu = .01, niter = 1000)

toy_summary <- untb_hill(toy_sim)

#### Run with a bunch of parameters ####

nrep = 10000

allNus <- runif(nrep, 0, 0.6)
allMs <- runif(nrep, 0, 0.6)

sims <- list()
hills <- list()

for(i in 1:nrep) {
  
  sims[[i]] <- untb(Jm = 10000,
                    Sm = 1000,
                    J = 1000,
                    m = allMs[i],
                    nu = allNus[i],
                    niter = 1000)
  
  hills[[i]] <- untb_hill(sims[[i]])
}


all_hills <- do.call(rbind, hills)

all_hills$Nu = allNus
all_hills$M = allMs

#### Visualize (or do interactively/adaptively) ####

library(ggplot2)

theme_set(theme_bw())

ggplot(all_hills, aes(M, Nu, color = hill0)) +
  geom_point() +
  scale_color_viridis_c()


ggplot(all_hills, aes(M, Nu, color = hill1)) +
  geom_point() +
  scale_color_viridis_c()


ggplot(all_hills, aes(M, Nu, color = hill2)) +
  geom_point() +
  scale_color_viridis_c()


ggplot(all_hills, aes(M, hill0, color = Nu)) +
  geom_point()

ggplot(all_hills, aes(M, hill1, color = Nu)) +
  geom_point()

ggplot(all_hills, aes(M, hill2, color = Nu)) +
  geom_point() 


ggplot(all_hills, aes(Nu, hill0, color = M)) +
  geom_point()

ggplot(all_hills, aes(Nu, hill1, color = M)) +
  geom_point()

ggplot(all_hills, aes(Nu, hill2, color = M)) +
  geom_point()


#### Random forest inference ####

library(randomForest)

train_rows <- sample(nrow(all_hills), size = 8000, replace = F)

train_dat <- all_hills[ train_rows,]
test_dat <- all_hills[ -train_rows, ]

train_hills <- train_dat[, 1:3]
train_nu <- train_dat[,"Nu"]
train_m <- train_dat[,"M"]

nu_rf <- randomForest(train_hills, train_nu, xtest = test_dat[,1:3], ytest = test_dat[,"Nu"])

nu_rf

plot(train_nu, nu_rf$predicted)


M_rf <- randomForest(train_hills, train_m, xtest = test_dat[,1:3], ytest = test_dat[,"M"])

M_rf

plot(train_m, M_rf$predicted)

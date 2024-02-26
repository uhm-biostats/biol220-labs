# Answer key for lab 07: probability

# 1. Use `sample` to make a data.frame with 40 rows and 2 columns: `x` and `y`. 
# Column `x` should be filled with a random sample of the the integers 1 and 2, 
# each with equal probability; column `y` should be filled with a random sample 
# of the letters A and B, each with equal probability.


dat <- data.frame(x = sample(c(1, 2), 40, replace = TRUE),
                  y = sample(c("A", "B"), 40, replace = TRUE))

# 2. To confirm their independence calculate Pr(y = A | x = 1) and 
# Pr(y = A) and evaluate if they are close to the same value.  

datXis1 <- subset(dat, dat$x == 1)

pAgiven1 <- mean(datXis1$y == "A")
pA <- mean(dat$y == "A")

pAgiven1
pA

# 3. Given that we simulate `y` and `x` as independent, why do we find that 
# Pr(y = A | x = 1) and Pr(y = A) and not exactly equal?  

# answer: because the data we simulated result from a random trial (using the
#         sample function) so some random variation is expected

# 3. (continued) If we simulated a data.frame with 80 rows, would you expect 
# Pr(y = A | x = 1) and Pr(y=A) to be more closely equal or more different? Why?

# answer: with a larger sample size we would expect the estimates to be more
#         close to equal because a larger sample size reduces sample error

# 4. Discuss in 2 to 3 sentence how you could change the code in (2.) to 
# simulate non-independence between the events in column `x` and column `y`. 

# answer: Non-independence means that knowing something about `x` should help
#         us better predict `y`. So we could, for example, make `y` equal "A" 
#         in all the rows where `x` equals 1, then Pr(y = A | x = 1) = 0 while
#         Pr(y = A) = 0.5


# 5. Fill in the probability figure. Use the made up data below to calculate the 
# probabilities of all the events in the figure 

# answers below:

# read-in data
fakefish <- read.csv("data/made_up_fish.csv")

# Pr(length > 40)
mean(fakefish$length_cm > 40)
# 0.475

# Pr(species = uhu)
mean(fakefish$species == "uhu")
# 0.5

# Pr(length > 40 & species = uhu)
mean(fakefish$length_cm > 40 & fakefish$species == "uhu")
# 0.375

# Pr(length <= 40 & species != uhu)
mean(fakefish$length_cm <= 40 & fakefish$species != "uhu")
# 0.4


# 6. Below, we have highlighted just two parts of the probability figure, use 
# the above made up data to calculate the probabilities in this figure.

# answers below:

# Pr(length > 40 & species != uhu)
mean(fakefish$length_cm > 40 & fakefish$species != "uhu")
# 0.1

# Pr(length <= 40 & species = uhu)
mean(fakefish$length_cm <= 40 & fakefish$species == "uhu")
# 0.125


# 7. Using conditional probabilities (e.g. Pr(A | B)), would you say that the 
# event of length > 40 and species = uhu are independent or not?

# answer: we need to calculate a conditional prob and the unconditional prob
p_uhu <- mean(fakefish$species == "uhu")

fakefish_greater40 <- subset(fakefish, fakefish$length_cm > 40)
p_uhu_given_greater40 <- mean(fakefish_greater40$species == "uhu")

p_uhu
# 0.5

p_uhu_given_greater40
# 0.789

# answer (continued): because Pr(uhu | length > 40) is so much more probable 
#                     than P(uhu) we conclude events in `x` and `y` are
#                     non-indipendent 

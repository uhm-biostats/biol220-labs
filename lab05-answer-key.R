# 1. First we need to do some data manipulation to add a column to our reef fish data that tells us if the sites are tropical or temperate (temperate refers to areas outside the tropics).

reef_fish <- read.csv("data/reef_fish.csv")


reef_fish$trop_or_temp <- "tropical"
reef_fish$trop_or_temp[reef_fish$lat >= 23.43615] <- "temperate"
reef_fish$trop_or_temp[reef_fish$lat <= -23.43615] <- "temperate"

# 2. Now that we have our column `trop_or_temp` telling us which group each data point belongs to, we need to state our null and alternative hypotheses

# H_0: the mean species richness across sites inside the tropics will be the 
# same as the mean species richness across sites outside the tropics

# H_A: the mean species richness across sites inside the tropics will be  
# *different* as the mean species richness across sites outside the tropics

# 3. Now calculate our test statistic

library(dplyr)
groups <- group_by(reef_fish, trop_or_temp)
group_means <- summarize(groups, ybar = mean(richness))

test_stat <- diff(group_means$ybar)
test_stat

# 4. Now we generate the null distribution. Let's do that in two steps:

# 4a. Refer to the code where we shuffled the `polynesia_isolation` of `pol_fish_null`. Use that example to make *one* random reshuffling of the `trop_or_temp` column and caculate *one* null test statistic

# make a copy
fish_null <- reef_fish

# reshuffle the group identities
fish_null$trop_or_temp <- sample(fish_null$trop_or_temp)

# follow the same steps as before for calculating the test statistic
groups_null <- group_by(fish_null, trop_or_temp)
group_means_null <- summarize(groups_null, ybar = mean(richness))

test_stat_null <- diff(group_means_null$ybar)
test_stat_null

# 4b. Now use the code from (4a.) and refer to the use of the `replicate` function to simulate a null distribution with 1000 replicates

null_dist <- replicate(1000, {
  # reshuffle the group identities
  fish_null$trop_or_temp <- sample(fish_null$trop_or_temp)
  
  # follow the same steps as before for calculating the test statistic
  groups_null <- group_by(fish_null, trop_or_temp)
  group_means_null <- summarize(groups_null, ybar = mean(richness))
  
  test_stat_null <- diff(group_means_null$ybar)
  test_stat_null
})


# 5. Plot a histogram of the null distribution

library(ggplot2)

# notice we need to make a data.frame in order for ggplot to work
null_dist_df <- data.frame(null_test_stat = null_dist)

ggplot(null_dist_df, aes(x = null_test_stat)) +
  geom_histogram()

# 6. Calculate the $p$-value for the two-tailed alternative hypothesis

lower_tail <- mean(null_dist >= test_stat)
upper_tail <- mean(null_dist <= -1 * test_stat)
pval <- lower_tail + upper_tail
pval


# 7. Decide whether we reject or fail to reject the null hypothesis

# The p-value is 0.11 (in my simulation) so we *fail to reject the null*

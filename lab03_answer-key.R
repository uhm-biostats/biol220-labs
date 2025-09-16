# 1. Import data

leafsize <- read.csv("data/wright_etal_2017.csv")
leafsize <- leafsize[, c("latitude", "leafsize_cm2")]
leafsize <- subset(leafsize, !is.na(leafsize_cm2))
leafsize <- subset(leafsize, abs(latitude) < 23.43655)
mean(leafsize$leafsize_cm2)

## 65.97642


# 2. Create 1000 replicates each of sample sizes of 64, 256, and 1024 from the 
# `leafize` data.frame 

library(infer)

# create replicate samples
sample_dist64 <- rep_slice_sample(leafsize, n = 64, reps = 1e3)

# add a column recording the sample size
sample_dist64$sample_size <- 64

# create replicate samples
sample_dist256 <- rep_slice_sample(leafsize, n = 256, reps = 1e3)

# add a column recording the sample size
sample_dist256$sample_size <- 256

# create replicate samples
sample_dist1024 <- rep_slice_sample(leafsize, n = 1024, reps = 1e3)

# add a column recording the sample size
sample_dist1024$sample_size <- 1024

# combine using `rbind`
sample_dists <- rbind(sample_dist64, 
                      sample_dist256, 
                      sample_dist1024)

head(sample_dists)

# 3. Use the `group_by()` and `summarize()` functions to calculate the sample 
# mean for each level of sample size (64, 256, or 1024) and replicate

sample_dists <- group_by(sample_dists, sample_size, replicate)
sample_dists <- summarize(sample_dists, Y_bar = mean(leafsize_cm2))


# 4. Make a multi-panel histogram with separate panels for each sample size
library(ggplot2)
g <- ggplot(sample_dists, aes(Y_bar)) +
    facet_grid(rows = vars(sample_size)) +
    geom_histogram()

g


# 5. How does the location and width of the sampling distribution for $\bar{Y}$ 
# change as $n$ increases?

# Location does not change substantially, the width gets narrower with larger
# sample size




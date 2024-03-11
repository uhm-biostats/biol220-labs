# 1. Keep building on the code you ran to make `samp`. Add another random sample of 1000 numbers, but this time from a $\chi^2$ distribution with 9 degrees of freedom.

# bringing over stuff from "learning the tools"
# generate the sample
chi2_df3 <- rchisq(1000, df = 3)

# put it in a data.frame
samp <- data.frame(chi2 = chi2_df3)

# first add a column for degrees of freedom
samp$df <- 3

# now make a new data.frame for df = 6 (next we'll combine the data.frames)
chi2_df6 <- rchisq(1000, df = 6)
samp_df6 <- data.frame(chi2 = chi2_df6, df = 6)

# now add that new data.frame onto `samp`
samp <- rbind(samp, samp_df6)

# now we add the new sample with df = 9
chi2_df9 <- rchisq(1000, df = 9)
samp_df9 <- data.frame(chi2 = chi2_df9, df = 9)

# now add that new data.frame onto `samp`
samp <- rbind(samp, samp_df9)


# 2. Make a faceted histogram with all three distributions captured in `samp`.

library(ggplot2)

ggplot(samp, aes(x = chi2)) +
    geom_histogram() +
    facet_grid(rows = vars(df))

# 3. Calculate the critical value for $\alpha = 0.05$ for the $\chi^2$ distribution with 9 degrees of freedom

critval_df9 <- qchisq(0.95, df = 9)
critval_df9

# 4. Use R code to estimate the probability from your random sample from the $\chi^2$ distribution with 9 degrees of freedom of values greater than or equal to the critical value you just calculated

nevent <- sum(chi2_df9 >= critval_df9)
nevent / length(chi2_df9)

# 5. Following the steps we used to do a $\chi^2$ goodness of fit test for `fake_data`, preform a $\chi^2$ goodness of fit test to answer the question of whether the ethnic composition of UH faculty resembles the ethnic composition of Hawaiʻi.  What do you conclude?

# read-in data
uh <- read.csv("data/uh_faculty_ethnicity.csv")

# add expected values
uh$expected <- uh$state_pop_proportion * sum(uh$number_uh_faculty)

# calculate chi-sqrd stat
chi2stat <- sum((uh$number_uh_faculty - uh$expected)^2 / 
                    uh$expected)

# figure out df

# 10 groups reported, so df is 9

# calculate p-value

pchisq(chi2stat, df = 9, lower.tail = FALSE)

# decide to reject or fail to reject

# we reject the null that UH faculty are representative of the Hawaiʻi 
# population in terms of ethnicity


# 6. Following the steps we used to do a contingency analysis for `fake_2var`, preform a contingency analysis for the manu o Kū nesting data. Do the manu have a preference for which type of tree to nest in, or do they seem to choose at random?

# read-in the data
manuoku <- read.csv("data/manuoku.csv")

# run the test
chisq.test(manuoku$tree, manuoku$nest)

# we get a p-value just below 0.05, and we get a warning about the 
# assumptions of the chi-sqrd test, so letʻs also run Fisherʻs exact test
fisher.test(manuoku$tree, manuoku$nest)

# an even smaller p-value, so yes, we can reject the null hypothesis 
# that the manu have no preference for which kind of tree to build a nest in

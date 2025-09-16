# 1. Use `binom.test()` to calculate the estimated proportion of choosing māmaki. What is the 95% confidence interval for this proportion? What is the two-tailed $P$-value of the null hypothesis?

binom.test(x = 38, n = 50, p = 0.5)

# estimated proportion: 0.76

# 95% CI: 0.6183093 0.8693901

# P-value: 0.0003059

#2. Based on the results form `binom.test` you just produced does it seem promising that pulelehua Kamehameha caterpillars will be able to use *Cecropia obtusifolia* as a food plant?

# we reject the null of no preference, therefore it is not very promising 
# that pulelehua Kamehameha caterpillars will use Cecropia as a food source

# 3. Based on the 95% confidence intervals, do you think the proportion of times the caterpillars choose māmaki over *Urtica* versus the proportion of times they choose māmaki over *Cecropia obtusifolia* are different from one another? Explain your answer.

# The 95% CI for māmaki vs Urtica was 0.5060410 0.8526548, which means the 
# estimated preference of the caterpillars almost included 0.5 (i.e. the null
# of no preference). The 95% CI for māmaki vs. Cecropia was further from 0.5
# indicating that caterpillar preference was stronger in māmaki vs. Cecropia
# however, the two confidence intervals overlap each other substantially
# and also the sample sizes are different. These two facts should temper any 
# conclusion about whether there is less preference between māmaki vs. urtica
# and māmaki vs. Cecropia


# 4. Find your own proportion data on the Internet or at home if you are doing this after lab. Develop a null hypothesis, state it in your report, and use `binom.test()` to test it. Did you reject your null hypothesis? Explain why or why not.

# could be all kinds of things.  The key is finding data for which there are
# ONLY 2 OUTCOMES (or data that can be foreced into 2 outcomes like the M&M
# example)

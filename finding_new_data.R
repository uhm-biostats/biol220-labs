X <- read.csv("~/Desktop/foo/FE.Case.Tarwater_2020.csv")

X$log_mass <- log(X$Body.mass_grams)
X$assemblage <- factor(X$Assemblage_historic.1_or_modern.0)
X$assemblage <- "modern"
X$assemblage[X$Assemblage_historic.1_or_modern.0 == 1] <- "historic"

ggplot(X, aes(x = log_mass)) + 
  geom_histogram()



ggplot(X, aes(x = log_mass, y = Gape.width_mm, color = assemblage)) +
  geom_point(alpha = 0.5)

X <- read.csv("~/Desktop/forest_restore_data/Nutrients_vs_Weeds___Growth.csv")
head(X)

ggplot(X, aes(x = N.released..g.plot., y = C.released..g.plot., 
              color = Treatment)) + 
  geom_point() +
  coord_trans(x = "log10", y = "log10")

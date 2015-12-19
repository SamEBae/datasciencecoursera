load("/Users/sammybae/Downloads/ravensData.rda")
head(ravensData)

#linear regression
lmRavens <- lm(ravensData$ravenWinNum ~ ravensData$ravenScore)
summary(lmRavens)

logRegRavens <- glm(ravensData$ravenWinNum ~ ravensData$ravenScore, family = "binomial")
summary(logRegRavens)
exp(logRegRavens$coeff)
exp(confint(logRegRavens))
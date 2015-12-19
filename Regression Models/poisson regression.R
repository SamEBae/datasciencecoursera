#many data take form of count data: e.g. calls to call center
#many data also take form of rate: e.g. percent of hits to website 

#poisson regression is great for these types of data
load("/Users/sammybae/Downloads/gaData.rda")
gaData$julian <- julian(gaData$date)
head(gaData)

plot(gaData$julian,gaData$visits,pch=19, col="grey",xlab="Julian",ylab = "Visits")
lm1 <- lm(gaData$visits~gaData$julian)
abline(lm1,col="red",lwd=3)
glm1 <- glm(gaData$visits ~ gaData$julian, family="poisson")
lines(gaData$julian, glm1$fitted, col="blue", lwd=3)
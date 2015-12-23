library(ISLR)
data(Wage)
library(ggplot2)
library(caret)
Wage <- subset(Wage,select=-c(logwage))
inBuild <- createDataPartition(y=Wage$wage, p=0.7, list=FALSE)
validation <- Wage[-inBuild,]
buildData <- Wage[inBuild,]
inTrain <- createDataPartition(y=buildData$wage, p=0.7, list=FALSE)
training <- buildData[inTrain,]
testing <- buildData[-inTrain,]

mod1 <- train(wage ~.,method="glm",data=training)
mod2 <- train(wage ~.,method="rf" ,data=training, trControl = trainControl(method="cv"), number=3)
pred1 <- predict(mod1,testing)
pred2 <- predict(mod2,testing)

qplot(pred1,pred2,colour=wage,data=testing)

predDF <- data.frame(pred1, pred2, wage=testing$wage)
combModFit <- train(wage ~.,method="gam",data=predDF)
combPred <- predict(combModFit,predDF)
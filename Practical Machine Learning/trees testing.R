
data(iris);
library(ggplot2);
inTrain <- createDataPartition(y=iris$Species, p=0.7, list=FALSE);
training <- iris[inTrain,]
testing <- iris[-inTrain,]

library(caret);
modFit <- train(Species~ .,data=training,method="rf",prox=TRUE);
modFit


getTree(modFit$finalModel,k=2)
head(Species)
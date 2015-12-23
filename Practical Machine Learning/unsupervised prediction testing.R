data(iris)
library(ggplot2)
library(caret)
inTrain <- createDataPartition(y=iris$Species, p=0.7, list=FALSE)

training <- iris[inTrain,]
testing <- iris[-inTrain,]
dim(training)
dim(testing)

kMeans1 <- kmeans(subset(training, select =-c(Species)), centers = 3)
training$clusters <- as.factor(kMeans1$cluster)
qplot(Petal.Width, Petal.Length, colour=clusters, data=training)
table(kMeans1$cluster, training$Species)

#build predictor
modFit <- train(clusters ~.,data=subset(training,select=-c(Species)),method="rpart")
table(predict(modFit,training),training$Species)

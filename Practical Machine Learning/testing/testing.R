library(knitr)
library(caret)
library(randomForest)
library(rpart)
library(rattle)
library(Hmisc)
library(plyr)

#Data Source:
setwd("C:/Users/Sam.E/Desktop/datasciencecoursera/Practical Machine Learning/")
training <- read.csv("pml-training.csv", na.strings=c("NA",""),stringsAsFactors = FALSE)
testing <- read.csv("pml-testing.csv", na.strings=c("NA",""),stringsAsFactors = FALSE)

dim(training)
dim(testing)


inTrain<-createDataPartition(y=training$classe, p=0.6, list=FALSE)
dataTraining<-training[inTrain, ]
dataTesting <- training[-inTrain, ]
dim(dataTraining)
dim(dataTesting)


## data cleaning 
index.for.undefined <- sapply(training, function(x) x=="#DIV/0!")
training[index.for.undefined] <- NA

# convert yes/no into 1/0
testing$new_window = 1*(testing$new_window=="yes")
testing$new_window <- as.factor(testing$new_window)

training$new_window = 1*(training$new_window=="yes")
training$new_window <- as.factor(training$new_window)
training$classe <- factor(training$classe)

## Removing variables
# remove variables with either 0 or NA 
unwanted <- names(training) %in% c("kurtosis_yaw_belt", "kurtosis_yaw_dumbbell", "kurtosis_yaw_forearm",
                                   "skewness_yaw_belt", "skewness_yaw_dumbbell", "skewness_yaw_forearm",
                                   "amplitude_yaw_belt", "amplitude_yaw_dumbbell", "amplitude_yaw_forearm")
training.new <- training[!unwanted]
#summary(training.new)

# remove unrelevant variables 
unwanted.2 <- names(training.new) %in% c("X", "user_name", "raw_timestamp_part_1", "raw_timestamp_part_2",
                                         "cvtd_timestamp") 
training.new <- training.new[!unwanted.2]
#summary(training.new)

# remove variables that's mostly NA's (> 95%) 
index.NA <- sapply(training.new, is.na)
Sum.NA <- colSums(index.NA)
percent.NA <- Sum.NA/(dim(training.new)[1])
to.remove <- percent.NA>.95
training.small <- training.new[,!to.remove]

# Data Partitioning- training/testing 
set.seed(10)
n <- length(training.small)
inTrain = createDataPartition(training.small$classe, p = 0.6)[[1]]
training.smaller <- training.small[inTrain,]
testing.smaller <- training.small[-inTrain,]
#summary(training.smaller)

## For the last model:

# setting option for 10-fold CV
train_control <- trainControl(method="cv", number=10)

# fit the model 
set.seed(100)
modelFit1 <- train(classe ~., method="rpart", data=training.smaller, 
                   trControl = train_control)
result1<- confusionMatrix(testing.smaller$classe, predict(modelFit1, newdata=testing.smaller))

# fit the model after preprocessing 
modelFit2 <- train(classe ~., method="rpart", preProcess=c("center", "scale"),data=training.smaller, 
                   trControl = train_control)
result2<- confusionMatrix(testing.smaller$classe, predict(modelFit2, newdata=testing.smaller))

result1

#dataTraining <- dataTraining[c(-1)]
#head(dataTraining)
#trainingModel <- train(classe ~ ., data=dataTraining, method="rf")

#nzv <- nearZeroVar(myTraining, saveMetrics=TRUE)
#myTraining <- myTraining[,nzv$nzv==FALSE]
#nzv<- nearZeroVar(myTesting,saveMetrics=TRUE)
#myTesting <- myTesting[,nzv$nzv==FALSE]

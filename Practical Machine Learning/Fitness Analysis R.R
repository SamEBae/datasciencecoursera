library(knitr)
library(caret)
library(randomForest)
library(rpart)
library(rpart.plot)
library(rattle)

#set the working directory
setwd("C:/Users/Sam.E/Desktop/datasciencecoursera/Practical Machine Learning/")
#Data Source:
if(!file.exists("pml-training.csv")){
  download.file("https://d396qusza40orc.cloudfront.net/predmachlearn/pml-training.csv", destfile = "pml-training.csv")
}
if(!file.exists("pml-testing.csv")){
  download.file("https://d396qusza40orc.cloudfront.net/predmachlearn/pml-testing.csv", destfile = "pml-testing.csv")
}

training <-read.csv("pml-training.csv", na.strings=c("NA",""),stringsAsFactors = FALSE)
testing <-read.csv("pml-testing.csv", na.strings=c("NA",""),stringsAsFactors = FALSE)
dim(training)
dim(testing)

## data cleaning 
index.for.undefined <- sapply(training, function(x) x=="#DIV/0!")
training[index.for.undefined] <- NA

#convert yes/no into 1/0
  #testing
    testing$new_window = 1*(testing$new_window=="yes")
    testing$new_window <- as.factor(testing$new_window)
  #training
    training$new_window = 1*(training$new_window=="yes")
    training$new_window <- as.factor(training$new_window)
    training$classe <- factor(training$classe)




## Removing variables
# remove variables with either 0 or NA 
NAVariables <- names(training) %in% c("kurtosis_yaw_belt", "kurtosis_yaw_dumbbell", "kurtosis_yaw_forearm",
                                   "skewness_yaw_belt", "skewness_yaw_dumbbell", "skewness_yaw_forearm",
                                   "amplitude_yaw_belt", "amplitude_yaw_dumbbell", "amplitude_yaw_forearm"
                                   )
#remove unrelevant variables 
unrelevant <- names(training) %in% c( "user_name", "raw_timestamp_part_1", "raw_timestamp_part_2","cvtd_timestamp") 
training <- training[!NAVariables]
training <- training[!unrelevant]



#remove variables that's mostly NA's (> 95%) 
index.NA <- sapply(training, is.na)
Sum.NA <- colSums(index.NA)
percent.NA <- Sum.NA/(dim(training)[1])
to.remove <- percent.NA>.95
dataTraining <- training[,!to.remove]

# Data Partitioning- training/testing 
set.seed(12345)
inTrain<-createDataPartition(y=training$classe, p=0.6, list=FALSE)
dataTraining<-training[inTrain, ]
dataTesting <- training[-inTrain, ]
dim(dataTraining)
dim(dataTesting)


#summary(training.smaller)
## For the last model:
# setting option for 10-fold CV
train_control <- trainControl(method="cv", number=10)

# fit the model 
set.seed(100)
modelFit1 <- train(classe ~., method="rf", data=dataTraining,trControl = train_control)
treeModel <- rpart(classe ~ ., data=dataTraining, method="class")
prp(treeModel)

#modelFit1
getTree(modelFit1$finalModel,k=2)


#result1<- confusionMatrix(testing.smaller$classe, predict(modelFit1, newdata=testing.smaller))
#modFitA1 <- rpart(classe ~ ., data=dataTraining, method="class")
#fancyRpartPlot(modelFit1)

# fit the model after preprocessing 
#modelFit2 <- train(classe ~., method="rpart", preProcess=c("center", "scale"),data=training.smaller,trControl = train_control)
#result2<- confusionMatrix(testing.smaller$classe, predict(modelFit2, newdata=testing.smaller))
#result1
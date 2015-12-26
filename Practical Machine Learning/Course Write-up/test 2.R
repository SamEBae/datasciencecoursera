library(knitr)
library(caret)
library(randomForest)
library(rpart)
library(rpart.plot)
library(rattle)

#set the working directory
setwd("C:/Users/Sam.E/Desktop/datasciencecoursera/Practical Machine Learning/Course Write-up")
#Data Source:
if(!file.exists("pml-training.csv")){
  download.file("https://d396qusza40orc.cloudfront.net/predmachlearn/pml-training.csv", destfile = "pml-training.csv")
}
if(!file.exists("pml-testing.csv")){
  download.file("https://d396qusza40orc.cloudfront.net/predmachlearn/pml-testing.csv", destfile = "pml-testing.csv")
}
training <-read.csv("pml-training.csv", na.strings=c("NA",""),stringsAsFactors = FALSE)
testing <-read.csv("pml-testing.csv", na.strings=c("NA",""),stringsAsFactors = FALSE)
dim(training);dim(testing)

#Data Preprocessing & Clean-up
#undefined data to N/A
undefinedToNA <- sapply(training, function(x) x=="#DIV/0!")
training[undefinedToNA] <- NA

#convert yes/no into 1/0
#testing
#testing$new_window = 1*(testing$new_window=="yes")
#testing$new_window <- as.factor(testing$new_window)
#training
#training$new_window = 1*(training$new_window=="yes")
#training$new_window <- as.factor(training$new_window)
#training$classe <- factor(training$classe)

#removes first column with ID and username
## Removing first 7 cols which only including log info seq No, user_name,time_stamp etc info
training<-training[, -(1:7)]

## Removing cols only containing NA or ""
thres <- nrow(clean.data) * 0.95  ## Setting threshoold as more than95% of NAs or ""
nNaColumns <- !apply(training, 2, function(x) sum(is.na(x)) > thres  || sum(x=="") > thres)
training <- training[, nNaColumns]

nzColumns <- nearZeroVar(training, saveMetrics = TRUE)
training <- training[, nzColumns$nzv==FALSE]
training$classe = factor(training$classe)


#remove N/A value columns
training <- training[, unlist(lapply(training, function(x) !any(is.na(x))))]
testing <- testing[, unlist(lapply(testing, function(x) !any(is.na(x))))]

dim(training);dim(testing)

#Data Partitioning
inTrain<-createDataPartition(y=training$classe, p=0.6, list=FALSE)
dataTraining<-training[inTrain, ]
dataTesting <-training[-inTrain, ]


#Model Building
##Method 1: Random Forrests
###Training the model with Random Forrests
trainingModelRF <- train(classe ~ .,trControl=trainControl(method = "cv", number = 5),data=dataTraining, method="rf")
print(trainingModelRF)


#fancyRpartPlot(trainingModelRF$finalModel)
###Prediction model with Random Forrests
predictionRF<-predict(trainingModelRF, dataTesting)
confusionMatrix(predictionRF, dataTesting$classe)


predictionRF<-predict(trainingModelRF, testing)
print(predictionRF)

###Plotting Random Forrests Model
qplot(predictionRF,classe,data=dataTesting)

###Accuracy of Random Forrests
accuracy <- postResample(predictionRF, dataTesting$classe)
model_accuracy <- accuracy[[1]]*100
model_accuracy

#Method 2: Generalized Boosted Regression (GBM)
###Training the model with GBM
modelGBM<-train(classe ~ .,method="gbm",data=dataTraining,verbose=FALSE)
print(modelGBM)
###Prediction model with Generalized Boosted Regression
predictionGBM<-predict(modelGBM, dataTesting)
confusionMatrix(predictionGBM, dataTesting$classe)
###Plotting Generalized Boosted Regression
qplot(predictionGBM,classe,data=dataTesting)
###Accuracy of Generalized Boosted Regression
accuracy <- postResample(predictionRF, dataTesting$classe)
model_accuracy <- accuracy[[1]]*100
model_accuracy


#Cross Validation
dataTesting$predRight <- predictionRF==dataTesting$classe;
qplot(classe, data=dataTesting, main="Predictions RF") + facet_grid(predRight ~ .)

dataTesting$predRight <- predictionGBM==dataTesting$classe;
qplot(classe, data=dataTesting, main="Predictions GBM") + facet_grid(predRight ~ .)


#Prediction
pml_write_files = function(x){
  n = length(x)
  for(i in 1:n){
    filename = paste0("problem_id_",i,".txt")
    write.table(x[i],file=filename,quote=FALSE,row.names=FALSE,col.names=FALSE)
  }
}
pml_write_files(predictionFinal)

#Summary

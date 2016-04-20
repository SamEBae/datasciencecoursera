#install reshape2 package if not already installed
#install.packages("reshape")
#install.packages("reshape2")

library(reshape)
library(reshape2)
#1. download the data from url if it doesn't exist in directory
  setwd("C:\\Users\\Sam.E\\Desktop\\datasciencecoursera\\Getting and Cleaning Data\\Final Project")
  getwd()
  fileName <- "getdata_dataset.zip"
  #download
  if (!file.exists(fileName)){
    url <- "http://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
    f <- file.path(getwd(), "getdata_dataset.zip")
    download.file(url, f)
  }
  #unzip it
  if (!file.exists("UCI HAR Dataset")) { 
    unzip(fileName) 
  }

#2. get activity labels and features  
  activityLabels <- read.table("UCI HAR Dataset/activity_labels.txt")
  activityLabels
  
  features <- read.table("UCI HAR Dataset/features.txt")
  features
    
#3. get only features reflecting mean or standard deviation
  filteredFeatures <- grep(".*mean.*|.*std.*", features[,2])
  
  #set its names column to
  filteredFeatures.names <- features[filteredFeatures,2]
  #replace '-mean' with 'Mean'
  filteredFeatures.names = gsub('-mean', 'Mean', filteredFeatures.names)
  #replace '-std' with 'Std'
  filteredFeatures.names = gsub('-std', 'Std', filteredFeatures.names)
  #trucate brackets
  filteredFeatures.names <- gsub('[-()]', '', filteredFeatures.names)
  filteredFeatures
#4. load training and testing data
  #training data
  trainX <- read.table("UCI HAR Dataset/train/X_train.txt")[filteredFeatures]
  trainY <- read.table("UCI HAR Dataset/train/Y_train.txt")
  trainSubjects <- read.table("UCI HAR Dataset/train/subject_train.txt")
  train <- cbind(trainSubjects, trainY, trainX)
  
  #testing data
  testX <- read.table("UCI HAR Dataset/train/X_train.txt")[filteredFeatures]
  testY <- read.table("UCI HAR Dataset/train/Y_train.txt")
  testSubjects <- read.table("UCI HAR Dataset/train/subject_train.txt")
  test <- cbind(testSubjects, testY, testX)

#5. merge the data set
  mergedData <- rbind(train,test)
  colnames(mergedData) <- c("subject", "activity", featuresWanted.names)
  
  #generate factors from activities & subjects
  mergedData$activity <- factor(mergedData$activity, levels = activityLabels[,1], labels = activityLabels[,2])
  mergedData$subject <- as.factor(mergedData$subject)
  
  #melt the data and cast it
  mergedData.new <- melt(mergedData, id = c("subject", "activity"))
  mergedData.mean <- cast(mergedData.new, subject + activity ~ variable, mean)
  
#6. Write to output file
  write.table(mergedData.mean, "output.txt", row.names = FALSE, quote = FALSE)
#1.Loading and preprocessing the data

#download the data from url if it doesn't exist in directory
  setwd("C:\\Users\\Sam.E\\Desktop\\datasciencecoursera\\Reproducible Research\\Assignment 1")
  getwd()
  fileName <- "getdata_dataset.zip"
#download
  if (!file.exists(fileName)){
    url <- "https://d396qusza40orc.cloudfront.net/repdata%2Fdata%2Factivity.zip"
    f <- file.path(getwd(), "getdata_dataset.zip")
    download.file(url, f)
  }
#unzip it
  if (!file.exists("repdata-data-activity")) { 
    unzip(fileName) 
  }

#read the data
  repData <- read.csv("activity.csv")
  
#2. What is mean total number of steps taken per day?
  library(ggplot2)
  step.mean <- tapply(repData$steps, repData$date, FUN=sum, na.rm=TRUE)
  aggregatedDay <- aggregate(steps ~ date, repData, as.vector)
  
  plot1<-qplot(step.mean, binwidth=1000, xlab="total number of steps taken each day")
  ggsave("plot1.png",plot1)
  
  mean(step.mean, na.rm=TRUE)
  median(step.mean, na.rm=TRUE)
  
  
#3. What is the average daily activity pattern?
  library(ggplot2)
  averageInterval<-aggregate(x=list(steps=repData$steps), by=list(interval=repData$interval), FUN=mean, na.rm=TRUE)
  aesOption <- aes(x=interval, y=steps)
  ggplot(data=averageInterval, aesOption) +
    geom_line()+xlab("5-minute interval")+ylab("average number of steps taken")
  
#4. Calculate Imputing missing values
  missing <- is.na(repData$steps)
  table(missing)
  
  #filling in missing values`
  fill.value <- function(steps, interval) {
    filled <- NA
    if (!is.na(steps))
      filled <- c(steps)
    else
      filled <- (averages[averages$interval==interval, "steps"])
    return(filled)
  }
  filled.data <- repData
  filled.data$steps <- mapply(fill.value, filled.data$steps, filled.data$interval)
  
  total.steps <- tapply(filled.data$steps, filled.data$date, FUN=sum)
  qplot(total.steps, binwidth=1000, xlab="total number of steps taken each day")
  mean(total.steps)
  median(total.steps)
#5. Are there differences in activity patterns between weekdays and weekends?
  library(reshape2)
  weekday.or.weekend <- function(date) {
    day <- weekdays(date)
    if (day %in% c("Monday", "Tuesday", "Wednesday", "Thursday", "Friday"))
      return("weekday")
    else if (day %in% c("Saturday", "Sunday"))
      return("weekend")
    else
      stop("invalid date")
  }
  filled.data$date <- as.Date(filled.data$date)
  filled.data$day <- sapply(filled.data$date, FUN=weekday.or.weekend)

  averages <- aggregate(steps ~ interval + day, data=filled.data, mean)
  plotFilled <- ggplot(averages, aes(interval, steps)) + geom_line() + xlab("5-minute interval") + ylab("Number of steps")
  #+ facet_grid(day ~ .)
  ggsave("plotFilled.png",plotFilled) 
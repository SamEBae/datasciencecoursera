# Reproducible Research Assignment 1
Sammie Bae
April 27, 2016  
 
Loading and preprocessing the data

```r
library(ggplot2)
repData <- read.csv("activity.csv")
```
 
What is mean total number of steps taken per day?

```r
step.mean     <- tapply(repData$steps, repData$date, FUN=sum, na.rm=TRUE)
aggregatedDay <- aggregate(steps ~ date, repData, as.vector)

```

1. Make a histogram of the total number of steps taken each day
![](stephistogram/png)<!-- -->

2. Calculate and report the mean and median of the total number of steps taken per day

```r
mean(step.mean, na.rm=TRUE)
```

Mean of the total number of steps taken per day:

```
## [1] 10766.19
```


```r
median(step.mean, na.rm=TRUE)
```

Median of the total number of steps taken per day:

```
## [1] 10765
```
What is the average daily activity pattern?


```r
averageInterval<-aggregate(x=list(steps=repData$steps), by=list(interval=repData$interval), FUN=mean, na.rm=TRUE)
```

1. Make a time series plot (i.e. type = "l") of the 5-minute interval (x-axis) and the average number of steps taken, averaged across all days (y-axis)
![](5mininterval.png)<!-- -->

2. Which 5-minute interval, on average across all the days in the dataset, contains the maximum number of steps?

```r
averageInterval$interval[which.max(averageInterval$step)]
```

```
## [1] 835
```
 
###Imputing missing values
1. Calculate and report the total number of missing values in the dataset (i.e. the total number of rows with NAs)

```r
sum(is.na(activity))
```

```
## [1] 2304
```
2. Devise a strategy for filling in all of the missing values in the dataset. The strategy does not need to be sophisticated. For example, you could use the mean/median for that day, or the mean for that 5-minute interval, etc.

3. Create a new dataset that is equal to the original dataset but with the missing data filled in.

```r
  fillValues <- function(steps, interval) {
    filled <- NA
    if (!is.na(steps))
      filled <- c(steps)
    else
      filled <- (averageInterval[averageInterval$interval==interval, "steps"])
    return(filled)
  }
  filledData <- repData
  filledData$steps <- mapply(fillValues, filledData$steps, filledData$interval)
```

```
## [1] 0
```

4. Make a histogram of the total number of steps taken each day and Calculate and report the mean and median total number of steps taken per day. Do these values differ from the estimates from the first part of the assignment? What is the impact of imputing missing data on the estimates of the total daily number of steps?
![](missing.png)<!-- -->
 
Are there differences in activity patterns between weekdays and weekends?
Answer: yes, there is generally more activity on weekends

 
For this part the weekdays() function may be of some help here. Use the dataset with the filled-in missing values for this part.

1. Create a new factor variable in the dataset with two levels - "weekday" and "weekend" indicating whether a given date is a weekday or weekend day.


```r
  weekday.or.weekend <- function(date) {
    day <- weekdays(date)
    weekends <-c("Saturday", "Sunday")
    weekdays <-c("Monday", "Tuesday", "Wednesday", "Thursday", "Friday")
    if (day %in% weekends)
      return("weekend")
    else if (day %in% weekdays)
      return("weekday")
    else
      stop("invalid date")
  }
  filledData$date <- as.Date(filledData$date)
  filledData$day <- sapply(filledData$date, FUN=weekday.or.weekend)
  
  par(mfrow = c(2, 2))
   
  averages <- aggregate(steps ~ interval + day, data=filledData, mean)
```
2. Make a panel plot containing a time series plot (i.e. type = "l") of the 5-minute interval (x-axis) and the average number of steps taken, averaged across all weekday days or weekend days (y-axis). 

![](weekday.png)<!-- -->
![](weekend.png)<!-- -->
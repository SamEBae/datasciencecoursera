#download the data from url if it doesn't exist in directory
  setwd("C:\\Users\\Sam.E\\Desktop\\datasciencecoursera\\Reproducible Research\\Assignment 2")
  getwd()
  fileName <- "repdata-data-StormData.csv.bz2"
#download
  if (!file.exists(fileName)){
    downloadURL <-"https://d396qusza40orc.cloudfront.net/repdata%2Fdata%2FStormData.csv.bz2"
    f <- file.path(getwd(), "repdata-data-StormData.csv.bz2")
    download.file(downloadURL, f)
  }
#unzip it
  if (!file.exists("repdata-data-StormData.csv")) { 
    unzip(fileName) 
  }

#read the data
  repData <- read.csv("repdata-data-StormData.csv")

#Your data analysis must address the following questions:

#Across the United States, which types of events (as indicated in the EVTYPE variable) are most harmful with respect to population health?
  #convert to upper type for EVTYPE
  repData$EVTYPE = toupper(repData$EVTYPE)
  dim(repData)
  
  #aggregate by EVTYPE and FATALITIES
  aggFatalrepData <- aggregate(FATALITIES ~ EVTYPE, data = repData, sum)
  #fatal greater than 0
  fatalData <- aggFatalrepData[aggFatalrepData$FATALITIES > 0, ]
  #order descending
  fatalOrder <- fatalData[order(fatalData$FATALITIES, decreasing = TRUE), ]
  head(fatalOrder)
  
  #highest fatalities
  fatalOrder[1,]
  topFatal <- fatalOrder[1:5,]
  barplot(topFatal[,2], col = rainbow(10), legend.text = topFatal[,1], 
          ylab = "Deaths", main = "5 events that caused most deaths")
  
  
#Across the United States, which types of events have the greatest economic consequences?
  names(repData)
  #economic damage PROPDMG
  
  #aggregate by EVTYPE and PROPDMG
  aggDMGrepData <- aggregate(PROPDMG ~ EVTYPE, data = repData, sum)
  #damage greater than 0
  DMGrepData <- aggDMGrepData[aggDMGrepData$PROPDMG > 0,]
  #order descending
  DMGrepOrder<- DMGrepData[order(DMGrepData$PROPDMG, decreasing = TRUE), ]
  head(DMGrepOrder)
  
  #highest damage
  DMGrepOrder[1,]
  topDMG <- DMGrepOrder[1:5,]
  
  barplot(topDMG[,2], col = rainbow(10), legend.text = topDMG[,1], 
          ylab = "$Property damage (USD)", main = "5 events that caused most economic damange")
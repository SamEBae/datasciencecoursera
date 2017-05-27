#download the data from url if it doesn't exist in directory
  setwd("C:\\Users\\Sam.E\\Desktop\\datasciencecoursera\\Exploratory Data Analysis\\Assignment 2")
  getwd()
  fileName <- "getdata_dataset.zip"
#download
  if (!file.exists(fileName)){
    url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
    f <- file.path(getwd(), "getdata_dataset.zip")
    download.file(url, f)
  }
#unzip it
  if (!file.exists("exdata-data-NEI_data")) { 
    unzip(fileName) 
  }

#read the data
  NEI <- readRDS("summarySCC_PM25.rds")
  SCC <- readRDS("Source_Classification_Code.rds")
  
#6. Compare emissions from motor vehicle sources in Baltimore City with emissions from 
#   motor vehicle sources in Los Angeles County, California (fips == "06037"). 
#   Which city has seen greater changes over time in motor vehicle emissions?
  LACali<-NEI[NEI$fips == "06037",]
  
  png("plot6.png", width=480, height=480)
  par(mfrow = c(1, 2))
  plot(BaltimoreCity$year,BaltimoreCity$Emissions, type="l", ylab="Emission", xlab="Baltimore City")
  plot(LACali$year,LACali$Emissions, type="l", ylab="Emission", xlab="Los Angeles")
  dev.off()
  #Answer: clear from graph that LA had much bigger change
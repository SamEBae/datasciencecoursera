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

#Questions:
#1. Have total emissions from PM2.5 decreased in the United States from 1999 to 2008? Using the base plotting system, 
# make a plot showing the total PM2.5 emission from all sources for each of the years 1999, 2002, 2005, and 2008.
##NEI$yearplot(NEI1999$Emissions, type="l", ylab="Emission", xlab="1999")
  png("plot1.png", width=480, height=480)
  par(mfrow = c(2, 2))
  NEI1999 <- NEI[NEI$year == '1999',]
  NEI2002 <- NEI[NEI$year == '2002',]
  NEI2005 <- NEI[NEI$year == '2005',]
  NEI2008 <- NEI[NEI$year == '2008',]
  
  plot(NEI1999$Emissions, type="l", ylab="Emission", xlab="1999")
  plot(NEI2002$Emissions, type="l", ylab="Emission", xlab="2002")
  plot(NEI2005$Emissions, type="l", ylab="Emission", xlab="2005")
  plot(NEI2008$Emissions, type="l", ylab="Emission", xlab="2008")
  dev.off()
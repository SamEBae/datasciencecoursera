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
  
#2. Have total emissions from PM2.5 decreased in the Baltimore City, Maryland (fips == "24510") from 1999 to 2008? 
# Use the base plotting system to make a plot answering this question.
  BaltimoreCity<-NEI[NEI$fips == "24510",]
  BaltimoreCity
  BaltimoreCity[BaltimoreCity(final),]
  
  png("plot2.png", width=480, height=480)
  plot(BaltimoreCity$year,BaltimoreCity$Emissions, type="l", ylab="Emission", xlab="Baltimore City")
  dev.off()
  #Answer: yes, it has decreased
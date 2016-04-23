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
  
#3. Of the four types of sources indicated by the type (point, nonpoint, onroad, nonroad) variable, 
#which of these four sources have seen decreases in emissions from 1999-2008 for Baltimore City? Which have seen increases in emissions from 1999-2008? 
#Use the ggplot2 plotting system to make a plot answer this question.
  library(ggplot2)
  
  BaltimoreCityPoint<-BaltimoreCity[BaltimoreCity$type == "POINT",]
  BaltimoreCityNonpoint<-BaltimoreCity[BaltimoreCity$type == "NONPOINT",]
  BaltimoreCityOnroad<-BaltimoreCity[BaltimoreCity$type == "ON-ROAD",]
  BaltimoreCityNonroad<-BaltimoreCity[BaltimoreCity$type == "NON-ROAD",]
  
  plot31<-ggplot(BaltimoreCityPoint, aes(x=year, y=Emissions)) +  geom_point(aes(colour = Emissions))
  ggsave("plot3.1.png",plot31)
  #Answer: lower 
  plot32<-ggplot(BaltimoreCityNonpoint, aes(x = factor(year), y=Emissions)) +  geom_point(aes(colour = Emissions))
  ggsave("plot3.2.png",plot32)
  #Answer: lower
  plot33<-ggplot(BaltimoreCityOnroad, aes(x = factor(year), y=Emissions)) +  geom_point(aes(colour = Emissions))
  ggsave("plot3.3.png",plot33)
  #Answer: lower
  plot34<-ggplot(BaltimoreCityNonroad, aes(x = factor(year), y=Emissions)) +  geom_point(aes(colour = Emissions))
  ggsave("plot3.4.png",plot34)
  #Answer: lower
  
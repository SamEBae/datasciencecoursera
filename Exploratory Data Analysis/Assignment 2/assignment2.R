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
  #Answer: definately increased
  
  #2. Have total emissions from PM2.5 decreased in the Baltimore City, Maryland (fips == "24510") from 1999 to 2008? 
  # Use the base plotting system to make a plot answering this question.
  BaltimoreCity<-NEI[NEI$fips == "24510",]
  BaltimoreCity
  BaltimoreCity[BaltimoreCity(final),]
  
  png("plot2.png", width=480, height=480)
  #dateFormat<- strptime(BaltimoreCity$year, "%d/%m/%Y %H:%M:%S")
  plot(BaltimoreCity$year,BaltimoreCity$Emissions, type="l", ylab="Emission", xlab="Baltimore City")
  dev.off()
  #Answer: yes, it has decreased
  
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
  
  
  #ggplot(BaltimoreCityNonpoint, aes(x = factor(year))) + geom_line(stat = "count")
  #ggplot(BaltimoreCityOnroad, aes(x = factor(year))) + geom_line(stat = "count")
  #ggplot(BaltimoreCityNonroad, aes(x = factor(year))) + geom_line(stat = "count")

  
  #4. Across the United States, how have emissions from coal combustion-related sources changed from 1999-2008?
  SCCCombustion <- SCC[grepl('coal', SCC$Short.Name),]
  NEICombustion <- NEI[NEI$SCC == SCCCombustion$SCC,]
  
  #plot it
  plot4<-ggplot(NEICombustion, aes(x = year, y=Emissions)) +  geom_point(aes(colour = Emissions))
  ggsave("plot4.png",plot4)
  
  #5. How have emissions from motor vehicle sources changed from 1999-2008 in Baltimore City?
  SCCMotor <- SCC[grepl('car', SCC$Short.Name),]
  BaltimoreCityMotor <-   NEI[NEI$fips=="24510" & NEI$type=="ON-ROAD",  ]
  
  #plot5 < -ggplot(BaltimoreCityMotor, aes(x = year, y=Emissions)) +  geom_point(aes(colour = Emissions))
  png("plot5.png", width=480, height=480)
  plot(BaltimoreCityMotor$Emissions, type="l", ylab="Emission", xlab="")
  dev.off()
  
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
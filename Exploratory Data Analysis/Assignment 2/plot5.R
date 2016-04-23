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
  
#5. How have emissions from motor vehicle sources changed from 1999-2008 in Baltimore City?
  SCCMotor <- SCC[grepl('car', SCC$Short.Name),]
  BaltimoreCityMotor <-   NEI[NEI$fips=="24510" & NEI$type=="ON-ROAD",  ]
  png("plot5.png", width=480, height=480)
  plot(BaltimoreCityMotor$Emissions, type="l", ylab="Emission", xlab="")
  dev.off()
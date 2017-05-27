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
  
#4. Across the United States, how have emissions from coal combustion-related sources changed from 1999-2008?
  SCCCombustion <- SCC[grepl('coal', SCC$Short.Name),]
  NEICombustion <- NEI[NEI$SCC == SCCCombustion$SCC,]
  
  #plot it
  plot4<-ggplot(NEICombustion, aes(x = year, y=Emissions)) +  geom_point(aes(colour = Emissions))
  ggsave("plot4.png",plot4)
setwd("C:\\Users\\Sam.E\\Desktop\\datasciencecoursera\\Exploratory Data Analysis\\Assignment 1")
getwd()


powerAllData <- read.table("household_power_consumption.txt", header=TRUE, sep=";", stringsAsFactors=FALSE, dec=".")
powerData <- powerAllData[powerAllData$Date %in% c("1/2/2007","2/2/2007") ,]

#converts into right date format
  dateFormat<- strptime(paste(subSetData$Date, subSetData$Time, sep=" "), "%d/%m/%Y %H:%M:%S") 


png("plot2.png", width=480, height=480)
#pass in the format, convert row into number for proper type casting.
#type="l" indicates line chart
#give it proper labels
plot(dateFormat,as.numeric(powerData$Global_active_power), type="l", xlab="days", ylab="Global Active Power (kilowatts)")
dev.off()

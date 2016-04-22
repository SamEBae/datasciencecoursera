setwd("C:\\Users\\Sam.E\\Desktop\\datasciencecoursera\\Exploratory Data Analysis\\Assignment 1")
getwd()


powerAllData <- read.table("household_power_consumption.txt", header=TRUE, sep=";", stringsAsFactors=FALSE, dec=".")
powerData <- powerAllData[powerAllData$Date %in% c("1/2/2007","2/2/2007") ,]


#powerData

png("plot1.png", width=480, height=480)
hist(as.numeric(powerData$Global_active_power), col="red", main="Global Active Power", xlab="Global Active Power (kilowatts)")
dev.off()
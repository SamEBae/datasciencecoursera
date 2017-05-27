setwd("C:\\Users\\Sam.E\\Desktop\\datasciencecoursera\\Exploratory Data Analysis\\Assignment 1")
getwd()


powerAllData <- read.table("household_power_consumption.txt", header=TRUE, sep=";", stringsAsFactors=FALSE, dec=".")
powerData <- powerAllData[powerAllData$Date %in% c("1/2/2007","2/2/2007") ,]

#converts into right date format
  dateFormat<- strptime(paste(subSetData$Date, subSetData$Time, sep=" "), "%d/%m/%Y %H:%M:%S") 


png("plot3.png", width=480, height=480)
#pass in the format, convert row into number for proper type casting.
#type="l" indicates line chart
#give it proper labels

#let's partition into 3 sections
names(powerData)
submeter1 <- powerData$Sub_metering_1
submeter2 <- powerData$Sub_metering_2
submeter3 <- powerData$Sub_metering_3

nameVector <- c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3")
colVector <- c("black", "red", "blue")

plot(dateFormat, submeter1, type="l", ylab="Energy Submetering", xlab="days")
lines(dateFormat, submeter2, type="l", col="red")
lines(dateFormat, submeter3, type="l", col="blue")
legend("topright", nameVector, lty=1, lwd=2.5, col=colVector)

#good night sweet prince
dev.off()

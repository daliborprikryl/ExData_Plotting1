# Step0: loads r packages "(sqldf) and (tcltk)"
library(sqldf);library(tcltk)

# Step1:Download Data set and unpack to data folder
setwd("4.Exploratory Data Analysis/Project1")
fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
destFile <- "4.Exploratory Data Analysis/Project1/HPC.zip"
download.file (url = fileUrl,destfile = destFile,method = "libcurl")
unzip (destFile ,exdir="Data")

# Step2:Read "household_power_consumption.txt" with dates "1/2/2007" and "2/2/2007"
mySql <- "select * from file where Date = '1/2/2007' or Date = '2/2/2007'"
myFile <- "4.Exploratory Data Analysis/Project1/Data/household_power_consumption.txt"
myData <- read.csv.sql(myFile,mySql,header=TRUE,sep=";")

# Step3: Creates new column in the dataset and converts to date_time format
myData$dateTime = paste(myData$Date, myData$Time)
myData$dateTime <- strptime(myData$dateTime, "%d/%m/%Y %H:%M:%S") 
attach(myData) 

# Step4: Creates 4 graphs in one window
png("plot4.png", width=480, height=480, units="px") 
par(mfrow=c(2,2)) 
plot(dateTime, as.numeric(as.character(Global_active_power)), type="l", xlab="", ylab="Global Active Power")
plot(dateTime, as.numeric(as.character(Voltage)), type="l", xlab="datetime", ylab="Voltage") 
plot(dateTime, as.numeric(as.character(Sub_metering_1)), type="l", xlab="", ylab="Energy sub metering", ylim=c(0,40)) 
lines(dateTime, as.numeric(as.character(Sub_metering_2)), col="red") 
lines(dateTime, as.numeric(as.character(Sub_metering_3)), col="blue") 
legend("topright", lty=1, bty="n", col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3" )) 
plot(dateTime, as.numeric(as.character(Global_reactive_power)), type="l", xlab="datetime", ylab="Global_reactive_power") 
dev.off()

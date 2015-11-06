## Copyright 06 November 2015 by Bruce Leistikow
## for Coursera Class entitled, "Exploratory Data Analysis"; Course ID: exdata-034
## 
## This R script named "plot3.R" performs the following:
## 1. Reads in the Household Power Consumption data file found on the UC Irvine Machine Learning Repository.
## 2. The data is subsetted to only two days in 2007 for the analysis.
## 3. Various dates and numbers are reformatted to useful classes.
## 4. A line plot of the Energy Sub Metering is generated and labeled appropriately.
## 5. A png file is written to disk with dimensions of 480x480 pixels.

library(lubridate)
library(graphics)

fileUrl <- "./household_power_consumption.txt"
hpc <- read.csv2(fileUrl)
hpcSub <- subset(hpc, hpc$Date=="1/2/2007" | hpc$Date=="2/2/2007")
hpcSub$Date <- as.Date(hpcSub$Date, format="%d/%m/%Y")
hpcSub$Global_active_power <- as.numeric(as.character(hpcSub$Global_active_power))
hpcSub$Global_reactive_power <- as.numeric(as.character(hpcSub$Global_reactive_power))
hpcSub$Voltage <- as.numeric(as.character(hpcSub$Voltage))
hpcSub <- transform(hpcSub, timestamp=as.POSIXct(paste(Date, Time)), "%d/%m/%Y %H:%M:%S")
hpcSub$Sub_metering_1 <- as.numeric(as.character(hpcSub$Sub_metering_1))
hpcSub$Sub_metering_2 <- as.numeric(as.character(hpcSub$Sub_metering_2))
hpcSub$Sub_metering_3 <- as.numeric(as.character(hpcSub$Sub_metering_3))

plot(hpcSub$timestamp, hpcSub$Sub_metering_1, type="l", xlab="", ylab="Energy sub metering")
lines(hpcSub$timestamp, hpcSub$Sub_metering_2, col="red")
lines(hpcSub$timestamp, hpcSub$Sub_metering_3, col="blue")
legend("topright", col=c("black","red","blue"), c("Sub_metering_1  ","Sub_metering_2  ", "Sub_metering_3  "), lty=c(1,1), lwd=c(1,1))
dev.copy(png, file="plot3.png", width=480, height=480)
dev.off()
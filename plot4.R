## Copyright 06 November 2015 by Bruce Leistikow
## for Coursera Class entitled, "Exploratory Data Analysis"; Course ID: exdata-034
## 
## This R script named "plot4.R" performs the following:
## 1. Reads in the Household Power Consumption data file found on the UC Irvine Machine Learning Repository.
## 2. The data is subsetted to only two days in 2007 for the analysis.
## 3. Various dates and numbers are reformatted to useful classes.
## 4. Sets up the drawing area with a 4-quad graphics area
## 5. Renders the first line plot of the Global Active Power usage
## 6. Renders the second line plot of the Voltage usage
## 7. Renders the third line plot of the Energy Sub Metering with the legend
## 8. Renders the fourth line plot of the Global Reactive Power
## 9. A png file is written to disk with dimensions of 480x480 pixels.

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

par(mfrow=c(2,2))

##Plot 1
plot(hpcSub$timestamp, hpcSub$Global_active_power, type="l", xlab="", ylab="Global Active Power")

##Plot 2
plot(hpcSub$timestamp, hpcSub$Voltage, type="l", xlab="datetime", ylab="Voltage")

##Plot 3
plot(hpcSub$timestamp, hpcSub$Sub_metering_1, type="l", xlab="", ylab="Energy sub metering")
lines(hpcSub$timestamp, hpcSub$Sub_metering_2, col="red")
lines(hpcSub$timestamp, hpcSub$Sub_metering_3, col="blue")
## The lty parameter sets the line type
## The lwd parameter set the line width
##The bty parameter removes the legend box
##The cex parameter sets the size of the text to be 3/4 of normal 
legend("topright", col=c("black","red","blue"), c("Sub_metering_1  ","Sub_metering_2  ", "Sub_metering_3  "), lty=c(1,1), bty="n", cex=.75) 


#Plot 4
plot(hpcSub$timestamp, hpcSub$Global_reactive_power, type="l", xlab="datetime", ylab="Global_reactive_power")

#OUTPUT
dev.copy(png, file="plot4.png", width=480, height=480)
dev.off()
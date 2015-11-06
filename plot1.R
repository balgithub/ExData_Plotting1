## Copyright 06 November 2015 by Bruce Leistikow
## for Coursera Class entitled, "Exploratory Data Analysis"; Course ID: exdata-034
## 
## This R script named "plot1.R" performs the following:
## 1. Reads in the Household Power Consumption data file found on the UC Irvine Machine Learning Repository.
## 2. The data is subsetted to only two days in 2007 for the analysis.
## 3. Various dates and numbers are reformatted to useful classes.
## 4. A histogram of the Global Active Power is generated and labeled appropriately.
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

hist(hpcSub$Global_active_power, main = paste("Global Active Power"), col="red", xlab="Global Active Power (kilowatts)")
dev.copy(png, file="plot1.png", width=480, height=480)
dev.off()

### Exploratory Data Analysis - Course Project 1
### 
### Reproduce Plot 1
### 1. Read in Electric Power Consumption data, found here:
###     https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip
### 2. Take subset of this data for dates 2007-02-01 and 2007-02-02
### 2. Create a PNG of a histogram plot of Global Active Power data


# load the dplyr library for quick data.frame manipulation
library("dplyr")

# read the entire text file and convert to dplyr data.frame
data <- read.table("household_power_consumption.txt", header = TRUE, sep = ";")
data <- tbl_df(data)

# take subset of data for the dates 2007.02.01 and 2007.02.02
data <- filter(data, Date == "1/2/2007" | Date == "2/2/2007")

# convert Global_active_power column of data to be numeric to prepare for plotting
data$Global_active_power <- as.numeric(as.character(data$Global_active_power))

# set the PNG device for plotting
png("plot1.png", width=480, height=480)

# plot histogram while specifying plot title, x axis label, and bar color to red
hist(data$Global_active_power, 
     main="Global Active Power", 
     xlab="Global Active Power(kilowatts)", 
     col="red")

# close the png device
dev.off()

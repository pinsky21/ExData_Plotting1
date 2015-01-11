
### Exploratory Data Analysis - Course Project 1
### 
### Reproduce Plot 2
### 1. Read in Electric Power Consumption data, found here:
###     https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip
### 2. Take subset of this data for dates 2007-02-01 and 2007-02-02
### 3. Create a PNG of a plot of Global Active Power data


# load the dplyr library for quick data.frame manipulation
library("dplyr")

# read the entire text file and convert to dplyr data.frame
data <- read.table("household_power_consumption.txt", header = TRUE, sep = ";")
data <- tbl_df(data)

# take subset of data for the dates 2007.02.01 and 2007.02.02
data <- filter(data, Date == "1/2/2007" | Date == "2/2/2007")

# convert Global_active_power column of data to be numeric to prepare for plotting
data$Global_active_power <- as.numeric(as.character(data$Global_active_power))

# combine Date and Time columns and convert to POSIXlt
data$DateTime <- strptime(paste(data$Date, data$Time, sep=" "), format="%d/%m/%Y %H:%M:%S")

# remove Date and Time columns and move DateTime to first column
data <- select(data, DateTime, Global_active_power:Sub_metering_3)

# set the PNG device for plotting
png("plot2.png", width=480, height=480)

# plot line graph while removing the x axis label and changing the y axis label
with(data, 
     plot(DateTime, 
          Global_active_power, 
          type="l", 
          xlab="", 
          ylab="Global Active Power (kilowatts)")
     )

# close the png device
dev.off()

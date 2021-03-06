
### Exploratory Data Analysis - Course Project 1
### 
### Reproduce Plot 4
### 1. Read in Electric Power Consumption data, found here:
###     https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip
### 2. Take subset of this data for dates 2007-02-01 and 2007-02-02
### 3. Create a PNG of 4 plots 


# load the dplyr library for quick data.frame manipulation
library("dplyr")

# read the entire text file and convert to dplyr data.frame
data <- read.table("household_power_consumption.txt", header = TRUE, sep = ";")
data <- tbl_df(data)

# take subset of data for the dates 2007.02.01 and 2007.02.02
data <- filter(data, Date == "1/2/2007" | Date == "2/2/2007")

### Prepare the data set for plotting ####

# convert columns of data to be plotted as numeric
data$Global_active_power <- as.numeric(as.character(data$Global_active_power))
data$Sub_metering_1 <- as.numeric(as.character(data$Sub_metering_1))
data$Sub_metering_2 <- as.numeric(as.character(data$Sub_metering_2))
data$Sub_metering_3 <- as.numeric(as.character(data$Sub_metering_3))
data$Voltage <- as.numeric(as.character(data$Voltage))
data$Global_reactive_power <- as.numeric(as.character(data$Global_reactive_power))


# combine Date and Time columns and convert to POSIXlt
data$DateTime <- strptime(paste(data$Date, data$Time, sep=" "), format="%d/%m/%Y %H:%M:%S")

# remove Date and Time columns and move DateTime to first column
data <- select(data, DateTime, Global_active_power:Sub_metering_3)

### Plot 4 charts of data ####

# set the PNG device for plotting
png("plot4.png", width=480, height=480)

# set the device to have 4 charts
par(mfcol = c(2, 2))

# CHART 1 ---
with(data, plot(DateTime, Global_active_power, type="l", xlab="", ylab="Global Active Power"))

# CHART 2 ---
with(data, plot(DateTime, Sub_metering_1, type="l", xlab="", ylab="Energy sub metering"))
with(data, points(DateTime, Sub_metering_2, type="l", col="red"))
with(data, points(DateTime, Sub_metering_3, type="l", col="blue"))
# add a legend with no border
lineColors <- c("black", "red", "blue")
legendLabels <- c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3")
legend("topright", lty=1, bty="n", col=lineColors, legend=legendLabels)

# CHART 3 ---
with(data, plot(DateTime, Voltage, type="l", xlab="datetime", ylab="Voltage"))

# CHART 4 ---
with(data, plot(DateTime, Global_reactive_power, type="l", xlab="datetime"))

# close the png device
dev.off()


### Exploratory Data Analysis - Course Project 1
### 
### Reproduce Plot 3
### 1. Read in Electric Power Consumption data, found here:
###     https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip
### 2. Take subset of this data for dates 2007-02-01 and 2007-02-02
### 3. Create a PNG of a plot of all 3 sub metering variables with a legend


# load the dplyr library for quick data.frame manipulation
library("dplyr")

# read the entire text file and convert to dplyr data.frame
data <- read.table("household_power_consumption.txt", header = TRUE, sep = ";")
data <- tbl_df(data)

# take subset of data for the dates 2007.02.01 and 2007.02.02
data <- filter(data, Date == "1/2/2007" | Date == "2/2/2007")

# convert Sub Metering columns of data to be numeric to prepare for plotting
data$Sub_metering_1 <- as.numeric(as.character(data$Sub_metering_1))
data$Sub_metering_2 <- as.numeric(as.character(data$Sub_metering_2))
data$Sub_metering_3 <- as.numeric(as.character(data$Sub_metering_3))

# combine Date and Time columns and convert to POSIXlt
data$DateTime <- strptime(paste(data$Date, data$Time, sep=" "), format="%d/%m/%Y %H:%M:%S")

# remove Date and Time columns and move DateTime to first column
data <- select(data, DateTime, Global_active_power:Sub_metering_3)

# set the PNG device for plotting
png("plot3.png", width=480, height=480)

# plot line graph of Sub_metering_1 data while removing the x axis label and 
# changing the y axis label
with(data, plot(DateTime, Sub_metering_1, 
          type="l", 
          xlab="", 
          ylab="Energy sub metering")
)

# add a line to the plot for Sub_metering_2 data and make it red
with(data, points(DateTime, Sub_metering_2, type="l", col="red"))

# add a line to the plot for Sub_metering_2 data and make it blue
with(data, points(DateTime, Sub_metering_3, type="l", col="blue"))

# add a legend
lineColors <- c("black", "red", "blue")
legendLabels <- c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3")
legend("topright", lty=1, col=lineColors, legend=legendLabels)

# close the png device
dev.off()

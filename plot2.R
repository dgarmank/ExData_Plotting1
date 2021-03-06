# this is file plot2.R
# The data input for this R-script can be obtained from:
# https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip
# You must manually unzip it.

# filter the file for the rows and columns of interest
# prioritize faster file read
if(require(data.table) == TRUE) {
    cat("using faster fread(), but more memory\n")
    twodays <- subset(fread("household_power_consumption.txt", sep = ";",
                    stringsAsFactors = FALSE),
                    Date %in% c("1/2/2007","2/2/2007"), 1:9)
} else if(require(utils) == TRUE) {
    cat("using slower read.csv(), but less memory\n")
    twodays <- subset(read.csv("household_power_consumption.txt", sep = ";",
                    stringsAsFactors = FALSE),
                    Date %in% c("1/2/2007","2/2/2007"), 1:9)
} else stop("need either library, data.table or utils")

# Open PNG device and create default 480x480 'plot1.png' in working directory
png(file = "plot2.png") 

# Create the plot and send to a file (not the screen)
# 10 hours of screwing around getting the x-axis to plot properly
# resulted in changing lowercase y to uppercase Y
# strptime creates a class that can be used to plot
plot(strptime(paste(twodays$Date, twodays$Time), "%d/%m/%Y %H:%M:%S"),
     twodays$Global_active_power,
     type = 'l',
     xlab = "",
     ylab = "Global Active Power (kilowatts)")

dev.off() # Close the PNG file device

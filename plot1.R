# this is file plot1.R
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
png(file = "plot1.png") 
# Create histogram and send to a file (not the screen)
hist(as.numeric(twodays$Global_active_power),
          freq=TRUE,
          col="red",
          main="Global Active Power",
          xlab="Global Active Power (kilowatts)",
          ylab="Frequency")

dev.off() # Close the PNG file device

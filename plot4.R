# this is file plot4.R
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
png(file = "plot4.png") 

mydatevec <- strptime(paste(twodays$Date, twodays$Time), "%d/%m/%Y %H:%M:%S")

# setup plotting rol/col arrangement
par(mfcol = c(2,2) )

# Create the plots and send to a file (not the screen)

# from plot2.R, row=1, col=1
plot(mydatevec,
     twodays$Global_active_power,
     type = 'l',
     xlab = "",
     ylab = "Global Active Power (kilowatts)")

# from plot3.R, row=2, col=1
plot(mydatevec,
     twodays$Sub_metering_1,
     type = 'l',
     xlab = "",
     ylab = "Energy Sub Metering")
lines(strptime(paste(twodays$Date, twodays$Time), "%d/%m/%Y %H:%M:%S"),
    twodays$Sub_metering_2, col = "red")
lines(strptime(paste(twodays$Date, twodays$Time), "%d/%m/%Y %H:%M:%S"),
      twodays$Sub_metering_3, col = "blue")
legend("topright",
       legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),
       lty=c(1,1,1), # gives the legend appropriate symbols (lines)
       col=c("black","red","blue"),
       bty = "n")

# row=1, col=2
plot(mydatevec,
     twodays$Voltage,
     type = 'l',
     xlab = "datetime",
     ylab = "Voltage")

# row=2, col=2
plot(mydatevec,
     twodays$Global_reactive_power,
     type = 'l',
     xlab = "datetime",
     ylab = "Global_reactive_power")

dev.off() # Close the PNG file device

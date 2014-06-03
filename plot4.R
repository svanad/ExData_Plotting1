# main function - loads data, shows plot on the screen and generates png
plot4 <- function() {
    data <- load.data4()
    datetimes <- convert.dates.times(data$Date, data$Time)
    paint.plot4(data, datetimes)
    
    png(filename = "plot4.png", width = 480, height = 480, units = "px", 
        bg = "transparent")
    paint.plot4(data, datetimes)
    dev.off()
}

# loads the data from the 'household_power_consumption.txt' file
# returns just the rows and columns needed for the creation of the plot
load.data4 <- function() {
    init <- read.table("household_power_consumption.txt", 
                       sep = ";", 
                       header = TRUE, 
                       na.strings = "?", 
                       stringsAsFactors = FALSE, 
                       nrows = 10)
    classes <- sapply(init, class)
    data <- read.table("household_power_consumption.txt", 
                       sep = ";", 
                       header = TRUE, 
                       na.strings = "?", 
                       stringsAsFactors = FALSE, 
                       colClasses = classes)
    data[data$Date == "1/2/2007" | data$Date == "2/2/2007", 
         c("Date", "Time", "Global_active_power", "Global_reactive_power", 
           "Voltage", "Sub_metering_1", "Sub_metering_2", "Sub_metering_3")]
}

# converts 2 characters vectors with separated dates and times
# into 1 vector with POSIXlt datetimes
convert.dates.times <- function(dates, times) {
    char.datetimes <- paste(dates, times)
    strptime(char.datetimes, "%d/%m/%Y %H:%M:%S")
}

# paints plot to a graphics device
paint.plot4 <- function(data, datetimes) {
    par(mfcol = c(2, 2))
    par(bg = "transparent")
    
    # top left plot
    plot(datetimes, data$Global_active_power, 
         xlab = "", 
         ylab = "Global Active Power", 
         type = "l")
    
    # bottom left plot
    plot(datetimes, data$Sub_metering_1, 
         xlab = "", 
         ylab = "Energy sub metering", 
         type = "l")
    lines(datetimes, data$Sub_metering_2, col = "red")
    lines(datetimes, data$Sub_metering_3, col = "blue")
    legend("topright", col = c("black", "red", "blue"), lty = 1, bty = "n", 
           legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
    
    # top right plot
    plot(datetimes, data$Voltage, 
         xlab = "datetime", 
         ylab = "Voltage", 
         type = "l")
    
    # bottom right plot
    plot(datetimes, data$Global_reactive_power, 
         xlab = "datetime", 
         ylab = "Global_reactive_power", 
         type = "l")
}

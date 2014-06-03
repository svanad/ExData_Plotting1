# main function - loads data, shows plot on the screen and generates png
plot3 <- function() {
    data <- load.data3()
    datetimes <- convert.dates.times(data$Date, data$Time)
    paint.plot3(data, datetimes)
    
    png(filename = "plot3.png", width = 480, height = 480, units = "px", 
        bg = "transparent")
    paint.plot3(data, datetimes)
    dev.off()
}

# loads the data from the 'household_power_consumption.txt' file
# returns just the rows and columns needed for the creation of the plot
load.data3 <- function() {
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
         c("Date", "Time", 
           "Sub_metering_1", "Sub_metering_2", "Sub_metering_3")]
}

# converts 2 characters vectors with separated dates and times
# into 1 vector with POSIXlt datetimes
convert.dates.times <- function(dates, times) {
    char.datetimes <- paste(dates, times)
    strptime(char.datetimes, "%d/%m/%Y %H:%M:%S")
}

# paints plot to a graphics device
paint.plot3 <- function(data, datetimes) {
    plot(datetimes, data$Sub_metering_1, 
         xlab = "", 
         ylab = "Energy sub metering", 
         bg = "transparent", 
         type = "l")
    
    lines(datetimes, data$Sub_metering_2, col = "red")
    lines(datetimes, data$Sub_metering_3, col = "blue")
    
    legend("topright", col = c("black", "red", "blue"), lty = 1, 
           legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
}

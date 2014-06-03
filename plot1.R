# main function - loads data, shows plot on the screen and generates png
plot1 <- function() {
    data <- load.data1()
    paint.plot1(data)
    
    png(filename = "plot1.png", width = 480, height = 480, units = "px", 
        bg = "transparent")
    paint.plot1(data)
    dev.off()
}

# loads the data from the 'household_power_consumption.txt' file
# returns just the rows and columns needed for the creation of the plot
load.data1 <- function() {
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
         "Global_active_power"]
}

# paints plot to a graphics device
paint.plot1 <- function(data) {
    hist(data, 
         col = "red", 
         xlab = "Global Active Power (kilowatts)", 
         main = "Global Active Power", 
         bg = "transparent")
}

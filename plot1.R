data.in.filename <- function() {
        "household_power_consumption.txt"
}
line.number.for.date <- function(date){
        ls <- grep(date, readLines(data.in.filename()))
        ls[1] - 1;
}
read.power.consumption.data <- function() {
        ln1 <- 66637 # line.number.for.date("1/2/2007")
        ln2 <- 68077 # line.number.for.date("2/2/2007")
        t1 <- read.table(data.in.filename(), header=FALSE, sep=";", skip=ln1, nrows=1440, colClasses="character", na.strings="?")
        t2 <- read.table(data.in.filename(), header=FALSE, sep=";", skip=ln2, nrows=1440, colClasses="character", na.strings="?")
        t3 <- rbind(t1, t2)
        names(t3) <- c("Date", "Time", "Global_active_power", "Global_reactive_power", "Voltage", "Global_intensity", "Sub_metering_1", "Sub_metering_2", "Sub_metering_3")
        t3$Date <- as.Date(t3$Date, format="%d/%m/%Y")
        t3 <- data.frame(t3)
        t3[,3] <- as.numeric(t3[,3])
        t3
}

din <- read.power.consumption.data()
png(filename = "plot1.png", width = 480, height = 480, units = "px", bg = "white")
par(mar = c(6, 6, 5, 4))
hist(din[,3]
     , main="Global Active Power"
     , xlab="Global Active Power (kilowatts)"
     , col="red")
dev.off()


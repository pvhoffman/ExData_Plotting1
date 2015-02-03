data.in.filename <- function() {
        "household_power_consumption.txt"
}

read.power.consumption.data <- function() {
        inp <- fread(data.in.filename(), colClasses="character")
        setnames(inp, c("Date", "Time", "Global_active_power", "Global_reactive_power", "Voltage", "Global_intensity", "Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
        inp$Date <- as.Date(inp$Date, format="%d/%m/%Y")

        ts <- inp[inp$Date=="2007-02-01" | inp$Date=="2007-02-02"]
        ts <- data.frame(ts)
        ts[,3] <- as.numeric(ts[,3])
        ts
}

din <- read.power.consumption.data()
png(filename = "plot1.png", width = 480, height = 480, units = "px", bg = "white")
par(mar = c(6, 6, 5, 4))
hist(din[,3]
     , main="Global Active Power"
     , xlab="Global Active Power (kilowatts)"
     , col="red")
dev.off()


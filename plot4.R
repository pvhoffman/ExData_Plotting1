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
        # t3$Date <- as.Date(t3$Date, format="%d/%m/%Y")
        t3 <- data.frame(t3)
        ## we only care about date_time, global_active_power, voltage, global_reactive_power & the 3 submetering colunms in this plot
        t3$Date_Time <- as.POSIXct(paste(t3$Date, t3$Time), format="%d/%m/%Y %H:%M:%S")
        t3$Global_active_power <- as.numeric(t3$Global_active_power)
        t3$Global_reactive_power <- as.numeric(t3$Global_reactive_power)
        t3$Voltage <- as.numeric(t3$Voltage)
        t3$Sub_metering_1 <- as.numeric(t3$Sub_metering_1)
        t3$Sub_metering_2 <- as.numeric(t3$Sub_metering_2)
        t3$Sub_metering_3 <- as.numeric(t3$Sub_metering_3)
        t3
}

ds <- read.power.consumption.data()

# 2 rows and 2 columns in the plot

png(filename="plot4.png"
    , width=640
    , height=640
    , units="px"
    , bg="white")

par(mfrow=c(2,2))
#1st plot is the date_time to global_active_power
plot(ds$Date_Time
     , ds$Global_active_power
     , type="l"
     , main=""
     , xlab=""
     , ylab="Global Active Power")
# lines(ds$Date_Time, ds$Global_active_power, col="black")

#2nd plot is date_time to voltage
plot(ds$Date_Time
     , ds$Voltage
     , type="l"
     , main=""
     , xlab="datetime"
     , ylab="Voltage")
# lines(ds$Date_Time, ds$Voltage, col="black")

#3rd plot is the submetering
plot(ds$Date_Time
     , ds$Sub_metering_1
     , type="l"
     , main=""
     , xlab=""
     , ylab="Energy sub metering")
# lines(ds$Date_Time, ds$Sub_metering_1, col="black")
lines(ds$Date_Time, ds$Sub_metering_2, col="red")
lines(ds$Date_Time, ds$Sub_metering_3, col="blue")
legend("topright"
       , c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3")
       , col=c("black", "red", "blue")
       , lty=1)

#4th plot is date_time to global_reactive_power
plot(ds$Date_Time
     , ds$Global_reactive_power
     , type="l"
     , main=""
     , xlab="datetime"
     , ylab="Global_reactive_power")
# lines(ds$Date_Time, ds$Global_active_power, col="black")

dev.off()


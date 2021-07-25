## Put four plots in one window.

library("data.table")

## Read in data from file then subset data for specified dates.
GAP <- data.table::fread(input = "household_power_consumption.txt"
                         , na.strings="?"
)

## Format date and time.
GAP[, DateTime := as.POSIXct(paste(Date, Time), format = "%d/%m/%Y %H:%M:%S")]

## Filter Dates for 2007-02-01 and 2007-02-02
TwoDaysOnly <- GAP[(DateTime >= "2007-02-01") & (DateTime < "2007-02-03")]

## Call for multiple plots.

DateTime <- strptime(paste(TwoDaysOnly$Date, TwoDaysOnly$Time, sep=" "), "%d/%m/%Y %H:%M:%S") 
GAP <- as.numeric(TwoDaysOnly$Global_active_power)
GRP <- as.numeric(TwoDaysOnly$Global_reactive_power)
Voltage <- as.numeric(TwoDaysOnly$Voltage)
SubMetering1 <- as.numeric(TwoDaysOnly$Sub_metering_1)
SubMetering2 <- as.numeric(TwoDaysOnly$Sub_metering_2)
SubMetering3 <- as.numeric(TwoDaysOnly$Sub_metering_3)

png("plot4.png", width=480, height=480)
par(mfrow = c(2, 2)) 

plot(DateTime, GAP, type="l", xlab="", ylab="Global Active Power")

plot(DateTime, Voltage, type="l", xlab="datetime", ylab="Voltage")

plot(DateTime, subMetering1, type="l", ylab="Energy Submetering", xlab="")
lines(DateTime, subMetering2, type="l", col="red")
lines(DateTime, subMetering3, type="l", col="blue")
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty=, lwd=2, col=c("black", "red", "blue"), bty="o")

plot(DateTime, GRP, type="l", xlab="datetime", ylab="Global_reactive_power")

dev.off()


library("data.table")


## Read in data from original file.
GAP <- data.table::fread(input = "household_power_consumption.txt"
                         , na.strings="?"
)


## Format date and time.
GAP[, DateTime := as.POSIXct(paste(Date, Time), format = "%d/%m/%Y %H:%M:%S")]

## Filter Dates for 2007-02-01 and 2007-02-02
TwoDaysOnly <- GAP[(DateTime >= "2007-02-01") & (DateTime < "2007-02-03")]

png("plot2.png", width=480, height=480)

## Plot 2

plot(x = TwoDaysOnly$DateTime, y = TwoDaysOnly$Global_active_power, type = "l", xlab = "", ylab="Global Active Power (kilowatts)")
dev.off()


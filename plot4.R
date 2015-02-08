
#
# Assuming you're keeping the data in ~/tmp/
#

housePowerData <- read.csv("~/tmp/household_power_consumption.txt", sep=";",na.strings="?")

#
# There must be a better way to construct the fulltime combination without paste-ing the string values together..
#

fulltimeFormat <- "%d/%m/%Y/%H:%M:%S"
housePowerData$fulltime <- strptime(
  paste(housePowerData$Date, housePowerData$Time, sep = "/"),
  format=fulltimeFormat
  )

#
# date < 2007-02-03 will give us everything *before* 2007-02-03, so 2007-02-03
#

dateFormat <- "%Y-%m-%d"
startDate <- strptime("2007-02-01", dateFormat)
endDate   <- strptime("2007-02-03", dateFormat)

#
# Only pick the required days
#

rangeHousePowerData <- housePowerData[housePowerData$fulltime >= startDate & housePowerData$fulltime < endDate,]

png("plot4.png",
    width=480,
    height=480
    )

#
# Partition the graphics device with 2x2 squares
#

par(mfcol=c(2,2), pty="s")

#
# Top left
#

plot(
  x=rangeHousePowerData$fulltime,
  y=rangeHousePowerData$Global_active_power,
  type="n",
  xlab="",
  ylab="Global Active Power (kilowatts)"
  )

lines(
  x=rangeHousePowerData$fulltime,  
  y=rangeHousePowerData$Global_active_power
  )

#
# Bottom left
#

#
# The drawLine function interferes with the graphic placement so ..
# Measure out with plot/submetering1 and then draw lines
#

plot(
  x=rangeHousePowerData$fulltime,
  y=rangeHousePowerData$Sub_metering_1,
  type="n",
  xlab="",
  ylab="Energy sub metering"
  )

lines(
  x=rangeHousePowerData$fulltime,
  y=rangeHousePowerData$Sub_metering_1,
  col="black"
  )

lines(
  x=rangeHousePowerData$fulltime,
  y=rangeHousePowerData$Sub_metering_2,
  col="red"
  )

lines(
  x=rangeHousePowerData$fulltime,
  y=rangeHousePowerData$Sub_metering_3,
  col="blue"
  )

legend("topright",lty="solid",col = c("black","red","blue"),legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))

#
# Top right
#

plot(
  x=rangeHousePowerData$fulltime,
  y=rangeHousePowerData$Voltage,
  type="n",
  xlab="datetime",
  ylab="Voltage"
  )

lines(
  x=rangeHousePowerData$fulltime,
  y=rangeHousePowerData$Voltage,
  col="black"
  )

#
# Bottom right
#

plot(
  x=rangeHousePowerData$fulltime,
  y=rangeHousePowerData$Global_reactive_power,
  type="n",
  xlab="datetime",
  ylab="Global_reactive_power"
  )

lines(
  x=rangeHousePowerData$fulltime,
  y=rangeHousePowerData$Global_reactive_power,
  col="black"
  )

dev.off()
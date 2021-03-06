
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

png("plot1.png",
    width=480,
    height=480
    )

hist(rangeHousePowerData$Global_active_power,
     col="red",
     main="Global Active Power",
     xlab="Global Active Power (kilowatts)"
     )

dev.off()
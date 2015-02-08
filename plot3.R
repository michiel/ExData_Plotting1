
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

png("plot3.png",
    width=480,
    height=480
    )

#
# Setup the plot and use the first data set (Sub_metering_1) to frame it
#

plot(
  y=rangeHousePowerData$Sub_metering_1,
  x=rangeHousePowerData$fulltime,
  xlab ="", 
  ylab="Energy sub metering",
  type = "n"  
  )

#
# This function did not exactly save as much typing as I'd hoped ..
#

drawLine <- function(x, y, color) {
  lines(
    x=x,
    y=y,
    col=color
    )
}

drawLine(
  rangeHousePowerData$fulltime,
  rangeHousePowerData$Sub_metering_1,
  "black"
)
drawLine(
  rangeHousePowerData$fulltime,
  rangeHousePowerData$Sub_metering_2,
  "red"
)
drawLine(
  rangeHousePowerData$fulltime,
  rangeHousePowerData$Sub_metering_3,
  "blue"
)
legend(
  "topright",
  lty="solid",
  col=c("black","red","blue"),
  legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3")
  )

dev.off()
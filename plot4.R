#To begin, download this file and unzip it into your R working directory.

#You can do this in R with the following code:

file <- read.csv("household_power_consumption.txt")

power <- read.table(file, header=T, sep=";")
power$Date <- as.Date(power$Date, format="%d/%m/%Y")
data <- power[(power$Date=="2007-02-01") | (power$Date=="2007-02-02"),]
#Erase the rest of the usesless data
rm(power)
data$Global_active_power <- as.numeric(as.character(data$Global_active_power))
data$Global_reactive_power <- as.numeric(as.character(data$Global_reactive_power))
data$Voltage <- as.numeric(as.character(data$Voltage))
#strptime() converts character vectors to POSIXlt. In that sense, it is similar to
#as.POSIXlt(), except that the input doesn't have to be in a particular format (YYYY-MM-DD).
data <- transform(data, timestamp=as.POSIXlt(paste(Date, Time)), "%d/%m/%Y %H:%M:%S")
data$Sub_metering_1 <- as.numeric(as.character(data$Sub_metering_1))
data$Sub_metering_2 <- as.numeric(as.character(data$Sub_metering_2))
data$Sub_metering_3 <- as.numeric(as.character(data$Sub_metering_3))

plot4 <- function() {
  par(mfrow=c(2,2))
  
  ##PLOT 1
  plot(data$timestamp,data$Global_active_power, type="l", xlab="", ylab="Global Active Power")
  ##PLOT 2
  plot(data$timestamp,data$Voltage, type="l", xlab="datetime", ylab="Voltage")
  
  ##PLOT 3
  plot(data$timestamp,data$Sub_metering_1, type="l", xlab="", ylab="Energy sub metering")
  lines(data$timestamp,data$Sub_metering_2,col="red")
  lines(data$timestamp,data$Sub_metering_3,col="blue")
  legend("topright", col=c("black","red","blue"), c("Sub_metering_1  ","Sub_metering_2  ", "Sub_metering_3  "),lty=c(1,1), bty="n", cex=.5) #bty removes the box, cex shrinks the text, spacing added after labels so it renders correctly
  
  #PLOT 4
  plot(data$timestamp,data$Global_reactive_power, type="l", xlab="datetime", ylab="Global_reactive_power")
  
  #OUTPUT
  dev.copy(png, file="plot4.png", width=480, height=480)
  dev.off()
}
plot4()

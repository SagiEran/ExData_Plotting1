#   plot1.R Script File
#   to be able to subset the data with ease a "sql"base approach will be easier
#   Using the sqldf library can use sql Select statements over the source txt file
library(sqldf)
library(lubridate)

#   Load a subset of the Data Feb 1-2 , 2007 from file
mydata <- read.csv.sql(file="household_power_consumption.txt", sep=";", header=TRUE, sql="select * from file where Date in ('1/2/2007', '2/2/2007')")

# Create an Auxliray date time column
mydata$DateTime <- paste(mydata$Date, mydata$Time, sep=" ")

# Convert the new Column to Date data type
mydata$DateTime <- dmy_hms(mydata$DateTime)

#   Create and open the png file stream for the plot
png(file="plot4.png",width=480,height=480)

#   Specify two rows and two columns plot area
par(mfrow=c(2,2))

# Draw the 1st quadrant (top left area) : Global active power
plot(mydata$DateTime, mydata$Global_active_power, type="n", xlab="",ylab="Global Active Power")
lines(mydata$DateTime, mydata$Global_active_power, type="l")

# Draw the 2nd quadrant (top right area) : voltage
plot(mydata$DateTime, mydata$Voltage, type="n", xlab="datetime",ylab="Voltage")
lines(mydata$DateTime, mydata$Voltage, type="l")

# Draw the 3rd quadrant (bottom left area) : Energy sub metering
plot(mydata$DateTime, mydata$Sub_metering_1, type="n", xlab="", ylab="Energy sub metering")
lines(mydata$DateTime, mydata$Sub_metering_1, type="l")
lines(mydata$DateTime, mydata$Sub_metering_2, type="l", col="red")
lines(mydata$DateTime, mydata$Sub_metering_3, type="l", col="blue")
legend("topright", legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),col=c("black", "red", "blue"), cex=1, lty=1)

# Draw the 4th quadrant (bottom right area) : Global_reactive_power
plot(mydata$DateTime, mydata$Global_reactive_power, type="n", xlab="datetime",ylab="Global_reactive_power")
lines(mydata$DateTime, mydata$Global_reactive_power, type="l")

#   Safetly close png file stream (By closing the current graphics device which is bounded for the png file)
dev.off()







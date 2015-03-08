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
png(file="plot3.png",width=480,height=480)

# Draw the chart to the graphical device
# since I'm using an English Hebrew Location, Week Days names are in Hebrew @ Chrt : thursday, Friday, Saturday
plot(mydata$DateTime, mydata$Sub_metering_1, type="n", xlab="", ylab="Energy sub metering")
lines(mydata$DateTime, mydata$Sub_metering_1, type="l")
lines(mydata$DateTime, mydata$Sub_metering_2, type="l", col="red")
lines(mydata$DateTime, mydata$Sub_metering_3, type="l", col="blue")

# Add Legend to the Chart (Based on Chart Column names)
legend("topright", legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),col=c("black", "red", "blue"), cex=0.8, lty=1)

#   Safetly close png file stream (By closing the current graphics device which is bounded for the png file)
dev.off()


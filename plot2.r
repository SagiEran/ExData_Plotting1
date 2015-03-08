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
png(file="plot2.png",width=480,height=480)

# Draw the chart to the graphical device
# since I'm using an English Hebrew Location, Week Days names are in Hebrew @ Chrt : thursday, Friday, Saturday
plot(mydata$DateTime, mydata$Global_active_power, type="n", xlab="",ylab="Global Active Power (kilowatts)")
lines(mydata$DateTime, mydata$Global_active_power, type="l")

#   Safetly close png file stream (By closing the current graphics device which is bounded for the png file)
dev.off()


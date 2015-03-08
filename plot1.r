#   plot1.R Script File
#   to be able to subset the data with ease a "sql"base approach will be easier
#   Using the sqldf library can use sql Select statements over the source txt file

library(sqldf)

#   Load a subset of the Data Feb 1-2 , 2007 from file
mydata <- read.csv.sql(file="household_power_consumption.txt", sep=";", header=TRUE, sql="select * from file where Date in ('1/2/2007', '2/2/2007')")

#   Create and open the png file stream for the plot
png(file="plot1.png",width=480,height=480)

#   Draw an histogram Chart
hist(mydata$Global_active_power, col="red", main="Global Active Power", freq=TRUE, xlab="Global Active Power (kilowatts)")

#   Safetly close png file stream (By closing the current graphics device which is bounded for the png file)
dev.off()

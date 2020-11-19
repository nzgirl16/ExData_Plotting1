#Installing and loading the required packages
install.packages("plyr")
library(plyr)


#Calculating the reqd memory for the data
mem <- (2075259 * 9) * 8
mem <- mem / ((2^20) * 1024)
    # mem = 0.14 Gb


#Downloading and extracting the data
url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(url, destfile="power.zip")
unzip("power.zip")
list.files(recursive=TRUE)
rawData <- read.table("household_power_consumption.txt", sep=";", header=TRUE,
    na.strings = "?")
    #rawData: df 2075259x9


#Adjusting the data to the requirements
processedData1 <- mutate(rawData,
    DateTime = as.POSIXlt(paste(Date,Time), format="%d/%m/%Y %H:%M:%S"))
    #processedData1: df 2075259x10
    #Added the DateTime column
processedData2 <- processedData1[,c(10,3:9)]
    #processedData2: df 2075259x8
    #Deleted the Date and Time columns which are already redundndant
beginDate <- as.Date("2007-02-01", format="%Y-%m-%d")
endDate <- as.Date("2007-02-02", format="%Y-%m-%d")
processedData3 <- subset(processedData2,
    as.Date(DateTime)>=beginDate & as.Date(DateTime)<=endDate)
    #processedData2: df 2880x8
    #Took only data from Feb 1-2, 2007
powerData <- processedData3


#Plotting
png("plot2.png", width=480, height=480)
with(powerData, plot(DateTime, Global_active_power, type="n",
    xlab="", ylab="Global Active Power (kilowatts)"))
with(powerData, lines(DateTime, Global_active_power))
dev.off()
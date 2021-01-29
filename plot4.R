## Courseera 
## JHU Data Science Course 4 - Exploratory data analysis
## Instructor: Roger D. Peng
## Course Project 1 (Wk1) - Plot4
setwd("C:/Users/bingh/Documents/JHU_Course4_ExploratoryDataAnalysis")

## Setup libraries

## Get dataset for  UC Irvine Machine Learning Repository
dnldzipfile <- "./data/Fhousehold_power_consumption.zip"

# Checking if archieve already exists.
if (!file.exists("dnldzipfile")){
  fileURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
  download.file(fileURL, dnldzipfile, method="curl")
}  
# Unzip downloaded file into ./UCI HAR Dataset
if (!file.exists("./data/household_power_consumption")) { 
  unzip(dnldzipfile, exdir = "./data", overwrite = TRUE) 
}

## Read in data: 2075260 rows and 9 columns
powerconsum <- read.table("./data/household_power_consumption.txt", sep=";", na.strings = "?",
                          col.names = c("date","time", "Global_active_power", "Global_reactive_power","Voltage","Global_intensity","Sub_metering_1","Sub_metering_2","Sub_metering_3"))
dim(powerconsum)

##only be using data from the dates 2007-02-01 and 2007-02-02
powerconsum$date2 <- as.Date( as.character(powerconsum$date), "%d/%m/%Y")
subPwr <- subset(powerconsum, powerconsum$date2 <= as.Date("2007-02-02") & powerconsum$date2 >= as.Date("2007-02-01"))
subPwr$time2 <- strptime(subPwr$time,format='%H:%M:%S')
subPwr$datetime <- as.POSIXct(paste(subPwr$date, subPwr$time), format="%d/%m/%Y %H:%M:%S")

dim(subPwr)
head(subPwr)

## set up PNG file with a width of 480 pixels and a height of 480 pixels.
png(filename = "./figure/plot4.png", width = 480, height = 480, units = "px") #open PNG device

## Plot 4: plot 2x2 graphic metrics
par(mfrow=c(2,2), mar=c(3,4,3,4))
with(subPwr, {
    plot(datetime, Global_active_power,type="l", 
          xlab="", ylab="Global Active Power (kilowatts)")
  
    plot(datetime, Voltage,type="l", xlab="datetime", ylab="Voltage")
     
    plot(datetime, Sub_metering_1, col="black", type="l", 
         xlab="", ylab="Energy sub metering")
      lines(datetime, Sub_metering_2, col="red", type="l")
      lines(datetime, Sub_metering_3, col="blue", type="l")
      legend("topright", col=c("black", "red", "blue"), c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
           lwd=2, lty=1)
    
    plot(datetime, Global_reactive_power,type="l", xlab="datetime", ylab="Global_reactive_power")

})

dev.off()


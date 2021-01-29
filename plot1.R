## Courseera 
## JHU Data Science Course 4 - Exploratory data analysis
## Instructor: Roger D. Peng
## Course Project 1 (Wk1) - Plot1
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
powerconsum <- read.table("./data/household_power_consumption.txt", sep=";",
                          col.names = c("date","time", "Global_active_power", "Global_reactive_power","Voltage","Global_intensity","Sub_metering_1","Sub_metering_2","Sub_metering_3"))
dim(powerconsum)

##only be using data from the dates 2007-02-01 and 2007-02-02
powerconsum$date2 <- as.Date( as.character(powerconsum$date), "%d/%m/%Y")
subPwr <- subset(powerconsum, powerconsum$date2 <= as.Date("2007-02-02") & powerconsum$date2 >= as.Date("2007-02-01"))
dim(subPwr)

## set up PNG file with a width of 480 pixels and a height of 480 pixels.
png(filename = "./figure/plot1.png", width = 480, height = 480, units = "px") #open PNG device

## Plot 1: histogram of Global active power
hist(as.numeric(subPwr$Global_active_power), col='red',
                xlab="Global Active Power (kilowatt)",
                ylab = "Frequency", main="Global Active Power")
                   

dev.off()


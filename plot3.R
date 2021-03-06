##This section downloads and reads in data from Electric Power Consumption data set.

if (!file.exists("data")) {
        dir.create("data")
}

fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"

if (!file.exists("./data/Dataset.zip")) {
        download.file(fileUrl, destfile = "./data/Dataset.zip")
}

if (!file.exists("./data/household_power_consumption.txt")) {
        unzip("./data/dataset.zip",exdir = "./data")
}
##Load libraries dplyr and lubridate:

library(dplyr)
library(lubridate)

hpc <- read.table("./data/household_power_consumption.txt", header = TRUE, sep = ";", stringsAsFactors = FALSE,na.strings = "?")

##Filter for dates = February 1 and February 2, 2007

hpc_Feb <- filter(hpc,Date == "1/2/2007"|Date == "2/2/2007")

hpc_Feb <- mutate(hpc_Feb,date_time = paste(Date,Time,sep = " "))

##Convert dates and time to class POSIXct

hpc_Feb[,"Date"] <- dmy(hpc_Feb[,"Date"])
hpc_Feb[,"date_time"] <- dmy_hms(hpc_Feb[,"date_time"])

hpc_Feb <- mutate(hpc_Feb, dow = wday(date_time,label = TRUE))


##Base Plot

par(new = FALSE)
with (hpc_Feb, plot(date_time,Sub_metering_1,type = "l",main = " ",ylab = "Energy sub metering", xlab = " "))
par(new = TRUE)
with (hpc_Feb, plot(date_time,Sub_metering_2,type = "l",main = " ",ylab = "Energy sub metering", xlab = " ", col="red", ylim = c(0,30), yaxt = "n"))
par(new = TRUE)
with (hpc_Feb, plot(date_time,Sub_metering_3,type = "l",main = " ",ylab = "Energy sub metering", xlab = " ", col="blue", ylim = c(0,30),yaxt = "n"))
legend("topright", lty = c(1,1,1), col = c("black","red","blue"), legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))
title(main = "Plot 3", adj = 0)



## Save plot in png file (width 480 pixels and height 480 pixels)


png(file = "plot3.png",width = 480,height = 480)

par(new = FALSE)
with (hpc_Feb, plot(date_time,Sub_metering_1,type = "l",main = " ",ylab = "Energy sub metering", xlab = " "))
par(new = TRUE)
with (hpc_Feb, plot(date_time,Sub_metering_2,type = "l",main = " ",ylab = "Energy sub metering", xlab = " ", col="red", ylim = c(0,30), yaxt = "n"))
par(new = TRUE)
with (hpc_Feb, plot(date_time,Sub_metering_3,type = "l",main = " ",ylab = "Energy sub metering", xlab = " ", col="blue", ylim = c(0,30),yaxt = "n"))
legend("topright", lty = c(1,1,1), col = c("black","red","blue"), legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))
title(main = "Plot 3", adj = 0)


dev.off()


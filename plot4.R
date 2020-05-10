library(lubridate)
library(dplyr)

# read and subset data, remove NA
ori_data <- read.table("household_power_consumption.txt", header=TRUE,
                       sep=";", na.strings = "?", 
                       colClasses = c('character','character','numeric',
                                      'numeric','numeric','numeric',
                                      'numeric','numeric','numeric'))
ori <- as_tibble(ori_data)
ori$Date <- dmy(ori$Date)
sub_data <- filter(ori, Date >= ymd("2007-2-1") & Date <= ymd("2007-2-2"))
sub_data <- sub_data[complete.cases(sub_data), ]

#add new column dateTime
dateTime <- paste(sub_data$Date, sub_data$Time)
sub_data2 <- mutate(sub_data, dateTime)
sub_data2$dateTime <- ymd_hms(sub_data2$dateTime)

# Plot 4

with(sub_data2, {
  plot(Global_active_power~dateTime, type="l",
       ylab="Global Active Power (kilowatts)", xlab="")
  plot(Voltage~dateTime, type="l",
       ylab="Voltage (volt)", xlab="")
  plot(Sub_metering_1~dateTime, type="l",
       ylab="Global Active Power (kilowatts)", xlab="")
  lines(Sub_metering_2~dateTime,col='Red')
  lines(Sub_metering_3~dateTime,col='Blue')
  legend("topright", col=c("black", "red", "blue"),lwd = 1,bty = "n",
         legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
  plot(Global_reactive_power~dateTime, type="l",
       ylab="Global Rective Power (kilowatts)",xlab="")
})

dev.copy(png, file="plot4.png", height=480, width=480)
dev.off()
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

#Plot 2
plot(sub_data2$Global_active_power~sub_data2$dateTime, type="l", 
     ylab="Global Active Power (kilowatts)", xlab="")
dev.copy(png,"plot2.png", width=480, height=480)
dev.off()
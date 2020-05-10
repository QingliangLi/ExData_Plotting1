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

# Plot 1
hist(sub_data$Global_active_power, main="Global Active Power", 
     xlab = "Global Active Power (kilowatts)", col="red")

dev.copy(png,"plot1.png", width=480, height=480)
dev.off()
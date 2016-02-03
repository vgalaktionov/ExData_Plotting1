library(data.table)
library(dplyr)
library(lubridate)

## Reads in data, converts date and time to POSIXct, subsets 1+2 February 2007
elec <- fread("household_power_consumption.txt", na.strings = "?")
elec <- elec %>% mutate(datetime = paste(Date, Time)) %>% 
        select(datetime, Global_active_power:Sub_metering_3) %>% 
        mutate(datetime = dmy_hms(datetime, tz = "Europe/Amsterdam")) %>%
        filter(datetime >= "2007-02-01" & datetime < "2007-02-03")

## sets up graphic device
png(filename = "plot3.png", width = 480, height = 480)

## plots the 3 submeterings as function of time, adds legend
leg <- colnames(elec)[6:8]
with(elec, plot(datetime, Sub_metering_1, type = "l", ylab = "Energy sub metering", xlab = ""))
with(elec, lines(datetime, Sub_metering_2, col = "red"))
with(elec, lines(datetime, Sub_metering_3, col = "blue"))
legend("topright", legend = leg, lty = 1, col = c("black", "red", "blue"))

## closes graphic device
dev.off()     
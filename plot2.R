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
png(filename = "plot2.png", width = 480, height = 480)

## plots global active power as function of time
with(elec, plot(datetime, Global_active_power, type = "l", ylab = "Global Active Power (kilowatts)", xlab = ""))

## closes graphic device
dev.off()
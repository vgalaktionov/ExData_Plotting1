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
png(filename = "plot4.png", width = 480, height = 480)

## sets up 4 plots
par(mfcol = c(2,2))

## plot 1: global active power as function of time
with(elec, plot(datetime, Global_active_power, type = "l", ylab = "Global Active Power", xlab = ""))

## plot 2: submeterings as function of time
leg <- colnames(elec)[6:8]
with(elec, plot(datetime, Sub_metering_1, type = "l", ylab = "Energy sub metering", xlab = ""))
with(elec, lines(datetime, Sub_metering_2, col = "red"))
with(elec, lines(datetime, Sub_metering_3, col = "blue"))
legend("topright", legend = leg, lty = 1, col = c("black", "red", "blue"))

## plot 3: voltage as function of time
with(elec, plot(datetime, Voltage, type = "l", ylab = "Voltage"))

## plot 4: global reactive power as function of time
with(elec, plot(datetime, Global_reactive_power, type = "l", ylab = "Global_reactive_power"))

## closes graphic device
dev.off()

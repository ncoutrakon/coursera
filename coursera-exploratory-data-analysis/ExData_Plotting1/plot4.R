df <- read.table("household_power_consumption.txt", header = F, sep = ";", na.strings = "?", skip =66637, nrow = 69517 - 66637)
headers <- read.table("household_power_consumption.txt", header = F, sep = ";", na.strings = "?",nrow = 1)
names(df) <- headers
 
df$Date <- as.Date(df$Date, format = "%d/%m/%Y")
timetemp <- paste(df$Date, df$Time)
df$Time <- strptime(timetemp, format = "%Y-%m-%d %H:%M:%S")

png(filename = "plot4.PNG", width = 480, height = 480)
par("mfcol" = c(2, 2), "mex" = .75, "mar" = c(5, 6, 1, 1.5))

plot(df$Time,  df$Global_active_power, ylab = "Global Active Power",
                        col = "black", type = "l", xlab = "")

plot(df$Time, df$Sub_metering_1, ylab = "Energy sub metering", xlab = "",  type = "l", col = "black")
        lines(df$Time, df$Sub_metering_2, col = "brown")
        lines(df$Time, df$Sub_metering_3, col ="blue")
        legend("topright", legend = names(df)[7:9], col = c("black", "brown", "blue"), lwd = 1)

plot(df$Time, df$Voltage, xlab = "datetime", ylab = "Voltage", type = 'l')

plot(df$Time, df$Global_reactive_power, xlab = "datetime", ylab = names(df)[4], type = 'l')

dev.off()
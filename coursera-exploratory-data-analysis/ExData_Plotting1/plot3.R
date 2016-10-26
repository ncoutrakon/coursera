df <- read.table("household_power_consumption.txt", header = F, sep = ";", na.strings = "?", skip =66637, nrow = 69517 - 66637)
headers <- read.table("household_power_consumption.txt", header = F, sep = ";", na.strings = "?",nrow = 1)
names(df) <- headers

df$Date <- as.Date(df$Date, format = "%d/%m/%Y")
timetemp <- paste(df$Date, df$Time)
df$Time <- strptime(timetemp, format = "%Y-%m-%d %H:%M:%S")

png(filename = "plot3.PNG", width = 480, height = 480)

plot(df$Time, df$Sub_metering_1, ylab = "Energy sub metering", xlab = "",  type = "l", col = "black")
        lines(df$Time, df$Sub_metering_2, col = "brown")
        lines(df$Time, df$Sub_metering_3, col ="blue")
        legend("topright", legend = names(df)[7:9], col = c("black", "brown", "blue"), lwd = 1)


dev.off()

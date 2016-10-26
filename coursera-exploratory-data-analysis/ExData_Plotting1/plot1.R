df <- read.table("household_power_consumption.txt", header = F, sep = ";", na.strings = "?", skip =66637, nrow = 69517 - 66637)
headers <- read.table("household_power_consumption.txt", header = F, sep = ";", na.strings = "?",nrow = 1)
names(df) <- headers
df$Date <- as.Date(df$Date, format = "%d/%m/%Y")
timetemp <- paste(df$Date, df$Time)
df$Time <- strptime(timetemp, format = "%Y-%m-%d %H:%M:%S")


png("plot1.PNG", width = 480, height = 480)

hist(df$Global_active_power, main = "Global Active Power",
        xlab = "Global Active Power (kilowatts)",
        col = "red")
dev.off()


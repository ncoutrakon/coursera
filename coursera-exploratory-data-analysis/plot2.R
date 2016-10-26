if(!exists("NEI")) NEI <- readRDS("summarySCC_PM25.rds")
if(!exists("SCC")) SCC <- readRDS("Source_Classification_Code.rds")

baltpol <- NEI[which(NEI$fips == "24510"),]

baltpolut <- setNames(aggregate(baltpol$Emissions, list(baltpol$year), sum), c("Year", "PM25"))

png("plot2.png")
barplot(baltpolut$PM25/1000, names.arg = baltpolut$Year, main = "Total PM2.5 Emisssions in Baltimore City",
        ylab = "Pollutant Count (thousands)", col = "brown", ylim = c(0, 4))
dev.off()
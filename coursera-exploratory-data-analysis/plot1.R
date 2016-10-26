if(!exists("NEI")) NEI <- readRDS("summarySCC_PM25.rds")
if(!exists("SCC")) SCC <- readRDS("Source_Classification_Code.rds")

totpolut <- setNames(aggregate(NEI$Emissions, list(NEI$year), sum), c("Year", "PM25"))

png("plot1.png")
barplot(totpolut$PM25/1000000, names.arg = totpolut$Year, main = "Total PM2.5 Emisssions", ylab = "Pollutant Count (millions)", col = "brown", axes = T,
        ylim = c(0,8))
dev.off()
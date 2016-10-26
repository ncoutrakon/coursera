library(ggplot2)
if(!exists("NEI")) NEI <- readRDS("summarySCC_PM25.rds")
if(!exists("SCC")) SCC <- readRDS("Source_Classification_Code.rds")

baltpolut <- NEI[which(NEI$fips == "24510"),]

vehicleSCC <- as.character(SCC[grep("Vehicles$", SCC$EI.Sector), 1])
vehiclepolut <- baltpolut[which(baltpolut$SCC %in% vehicleSCC),]

vehicleyear <- tapply(vehiclepolut$Emissions, vehiclepolut$year, sum)
png("plot5.png")
barplot(vehicleyear, ylab ="Pollutants", main = "Vehicle Emissions in Baltimore City",
        ylim = c(0, 400))
dev.off()
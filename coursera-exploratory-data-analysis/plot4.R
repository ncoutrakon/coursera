library(ggplot2)
if(!exists("NEI")) NEI <- readRDS("summarySCC_PM25.rds")
if(!exists("SCC")) SCC <- readRDS("Source_Classification_Code.rds")


coalSCC <- as.character(SCC[grep("Coal$", SCC$EI.Sector), 1])
coalpolut <- NEI[which(NEI$SCC %in% coalSCC),]

coalyear <- tapply(coalpolut$Emissions, coalpolut$year, sum)

png("plot4.png")
barplot(coalyear/1000, ylab ="Pollutants (thousands)", main = "Coal Combustion in US",
        ylim = c(0, 700))
dev.off()
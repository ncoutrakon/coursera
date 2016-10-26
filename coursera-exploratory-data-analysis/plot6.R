library(ggplot2)
if(!exists("NEI")) NEI <- readRDS("summarySCC_PM25.rds")
if(!exists("SCC")) SCC <- readRDS("Source_Classification_Code.rds")
#Baltimore
bpolut <- NEI[which(NEI$fips == "24510"),]

bvehicleSCC <- as.character(SCC[grep("Vehicles$", SCC$EI.Sector), 1])
bvehiclepolut <- bpolut[which(bpolut$SCC %in% bvehicleSCC),]
Baltem <- tapply(bvehiclepolut$Emissions, bvehiclepolut$year, sum)


#LA
LApolut <- NEI[which(NEI$fips == "06037"),]

LAvehicleSCC <- as.character(SCC[grep("Vehicles$", SCC$EI.Sector), 1])
LAvehiclepolut <- LApolut[which(LApolut$SCC %in% LAvehicleSCC),]
LAem <- tapply(LAvehiclepolut$Emissions, LAvehiclepolut$year, sum)

#combine to df
cityvem <- c(Baltem, LAem)


#graphics 

png("plot6.png")
barplot(matrix(cityvem, nrow = 4), beside=T, 
        col=c("aquamarine3","coral"), 
        names.arg= c("Baltimore City", "LA"))
legend("topleft", rownames(LAem), pch = 15, col=c("aquamarine3","coral"), 
       bty = "n", cex = .9)
dev.off()


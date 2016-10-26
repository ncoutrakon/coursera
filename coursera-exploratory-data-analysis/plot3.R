library(ggplot2)
if(!exists("NEI")) NEI <- readRDS("summarySCC_PM25.rds")
if(!exists("SCC")) SCC <- readRDS("Source_Classification_Code.rds")

Ftypolut <- aggregate(NEI$Emissions, list(NEI$type, NEI$year), sum)

png("plot3.png")
ggplot(Ftypolut, aes(x = as.character(Group.2), y = x/1000)) + geom_bar(stat = "identity")+ 
        facet_grid( .~ Group.1) + theme(axis.text.x = element_text( angle = 90))+
        xlab("") + ylab("Pollutant Count (thousands)")
dev.off()
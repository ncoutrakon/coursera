library(ggplot2)
library(reshape)
library(gridExtra)
setwd("./coursera-reproducible-research")

#DOWNLOAD DATA
sturl <- "https://d396qusza40orc.cloudfront.net/repdata%2Fdata%2FStormData.csv.bz2"
stfile <- "stormdata.csv"
if(!file.exists(stfile)) {download.file(sturl, stfile, method = "curl"); stormdownloadDate<- date()}
if(!exists("stormdf")) stormdf <- read.csv(stfile, stringsAsFactors = F, na.strings = "")

##PREPROCESSING
stormdf$posixtime <- strptime(stormdf[,2], "%m/%d/%Y %H:%M:%S")
stormdf$year <- as.numeric(format(stormdf$posixtime, "%Y"))

#number of Event Types per year, plot it
freqEVTYPE <- setNames(aggregate(stormdf$EVTYPE, list(stormdf$year), function(x) length(table(x))), c("Year", "Types"))
qplot(Year, Types, data = freqEVTYPE, ylab = "Types of Events", main = "Event Types Reported")

#how many events were reported in total, each year. plot it
freqyear <- setNames(as.data.frame(table(stormdf$year), stringsAsFactors = F), c("Year", "Events"))
freq <- merge(freqyear, freqEVTYPE, by = "Year")
freq$Year <- as.numeric(freq$Year)
qplot(Year, Events, data = freq, ylab = "Number of Events", main = "Total Events Reported") + 
        theme(axis.text.x = element_text(angle = 90, hjust = 1))


#Between 1993 and 2002
#the different types of events reported ranges from 100 to 400. A further eploration of
#these events tells us that this varying amount can be attributed to lack of consolidation
#and direction in the data entry process. After 2007, we see the number of event types
#reported is much more consistent which is in line with when the NWS consolidated the standards
#many of itsreporting branches.
#So for this analysis, we are only going to use the data after this consolidation.
        
rstormdf <- stormdf[which(stormdf$year > 2007),]        

#consider removing
nEVTYPES <- setNames(as.data.frame(table(rstormdf$EVTYPE), stringsAsFactors = F),c("Event", "Event Count"))
nEVTYPES <- nEVTYPES[order(nEVTYPES$'Event Count', decreasing = T),]



##ECONOMIC DAMAGES

multiplier <- c("0" = 1, K = 10^3, M = 10^6, B = 10^9)

rstormdf$cropmult <-multiplier[rstormdf$CROPDMGEXP]
rstormdf$propmult <-multiplier[rstormdf$PROPDMGEXP]
rstormdf$damage <- rstormdf$CROPDMG * rstormdf$cropmult + rstormdf$PROPDMG * rstormdf$propmult


#creates df for total economic damages by event
econdmg <- setNames(aggregate(rstormdf$damage, list(rstormdf$EVTYPE), sum), c("Event","Damage.USD"))
econdmg <- merge(econdmg, nEVTYPES)
econdmg$DMGper <- econdmg$Damage / econdmg$'Event Count' 
econdmg <- econdmg[order(econdmg$Damage, decreasing = T),]
econdmg <- transform(econdmg, Event = reorder(Event, Damage))

eplot1 <- qplot(Event, Damage, data = econdmg, xlab ="", ylab = "Damage ($)", main = "Crop and Property Damage")+
        theme(axis.text.x = element_text(angle = 90, hjust = 1))

eplot2 <- qplot(x = reorder(Event, DMGper), DMGper, data = econdmg, xlab ="", ylab = "Damage per Event ($)", main = "Average Crop and Property Damage")+
        theme(axis.text.x = element_text(angle = 90, hjust = 1))

grid.arrange(eplot1, eplot2, ncol = 1)
#In this case, it looks like the top7 events and we will include only that as part of our
#economic damages recommendation. Right around2.5*10^9. Also note, that on a per event basis, Tsunamis and Storm Surge/Tides
#can be the most costly

recondmg <- econdmg[which((econdmg$Damage > 2.5*10^9)|(econdmg$Event %in% c("TSUNAMI", "STORM SURGE/TIDE"))),]



##POPULATION HEALTH
#creates  df for total fatalities and injuries by event
#arbitrarily chose to weight Injuries by .6 so as a way to compare fatalities and injuries
#in another analysis, this number could be changed
evfatal <- setNames(aggregate(rstormdf$FATALITIES, list(rstormdf$EVTYPE), sum), c("Event", "Fatalities"))
evinj <- setNames(aggregate(rstormdf$INJURIES, list(rstormdf$EVTYPE), sum), c("Event", "Injuries"))

popdmg <- merge(evfatal, evinj)
popdmg <- merge(popdmg, nEVTYPES)
popdmg$evDMG <- popdmg$Fatalities + .6*popdmg$Injuries
popdmg$evDMGper <- popdmg$evDMG / popdmg$'Event Count'*100 
popdmg <- popdmg[order(popdmg$evDMG, decreasing = T),]
popdmg <- transform(popdmg, Event = reorder(Event, evDMG))
qplot(Event, evDMG, data = popdmg, ylab = "Estimated Damage", main = "Weighted Total of Fatalities and Injuries")+
        theme(axis.text.x = element_text(angle = 90, hjust = 1))
#Clearly Tornadoes cause the most damage to population health, but lets remove that as an outlier
#and take a look at the data from here
outpopdmg <- popdmg[popdmg$Event != "TORNADO",]

pplot1 <- qplot(Event, evDMG, data = outpopdmg, ylab = "Estimated Damage", main = "Weighted Total of Fatalities and Injuries (Tornados Removed)")+
                theme(axis.text.x = element_text(angle = 90, hjust = 1))
pplot2 <- qplot(x = reorder(Event, evDMGper), evDMGper, data = outpopdmg, ylab = "Estimated Damage per Event", main = "Weighted Total of Fatalities and Injuries per Event (Tornados Removed)")+
                theme(axis.text.x = element_text(angle = 90, hjust = 1))

grid.arrange(pplot1, pplot2, ncol = 1)

#Again, note that Tsunamis have been underestimated on a per event basis, we'll include them
#Based on this, its seems like 200 in evDMG is a good cutoff point.
#Lets remove everything else and use only those points as part of our recommendation,
#including Tornadoes of course
rpopdmg <- popdmg[which((popdmg$evDMG > 200)| (popdmg$Event %in% c('TSUNAMI', "AVALANCHE"))),]
combodf <- merge(rpopdmg,recondmg)

recondmg
rpopdmg
combodf



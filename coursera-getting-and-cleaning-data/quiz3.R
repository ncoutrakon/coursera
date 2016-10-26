options(stringsAsFactors = F)
#Q1
setwd("./coursera-getting-and-cleaning-data")
daturl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv"
download.file(daturl, "q2data.csv", method = "curl")
datdownloadDate <- date()
df <- read.csv("q2data.csv")
which((df$ACR == 3) & (df$AGS == 6))

#Q2
library(jpeg)
jpegurl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fjeff.jpg"
download.file(jpegurl, "q2.jpg", method = "curl")
jpegdownloadDate <- date()

profpic <- readJPEG("q2.jpg", native = T)
quantile(profpic, c(.30, .80))

#Q3
gdpurl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv"
edurl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv"
gdpeddownloadDate <- date()
download.file(gdpurl, "gdpdf.csv", method = "curl")
download.file(edurl, "eddf.csv", method = "curl")
gdpdf <- read.csv("gdpdf.csv", na.strings = "..", skip = 5, nrow = 190, header = F)
eddf <- read.csv("eddf.csv")


mergdf <- merge(eddf, gdpdf, by.x = 1, by.y =1)
mergdf <- mergdf[c(1, 2, 3, 32)]
#mergdf[,2] <- as.numeric(mergdf[,3])
q3df <- mergdf[order(mergdf[,3], decreasing = T),]
q3df[13,]

#Q4
mean(mergdf[which(mergdf$Income.Group == "High income: nonOECD"), 4])
mean(mergdf[which(mergdf$Income.Group == "High income: OECD"), 4])

#Q5
q4df <- cut(mergdf$V2, quantile(mergdf$V2, probs = c(0, .20, .40, .60, .80, 1)))
table(q4df, mergdf$Income.Group)


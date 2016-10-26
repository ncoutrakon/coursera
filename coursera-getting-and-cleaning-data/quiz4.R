#Q1
q1url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv"
download.file(q1url, destfile = "./q1data.csv", method = "curl")
download1Date <- date()
dat1 <- read.csv("./q1data.csv")
head(dat1)
q1 <- strsplit(colnames(dat1), split= "wgtp", fixed = T)
unlist(q1)[123]
#Q2
q2url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv"
download.file(q2url, destfile = "./q2data.csv", method = "curl")
download2Date <- date()
dat2 <- read.csv("./q2data.csv", skip = 4, na.strings = "")
head(dat2)
dat2 <- dat2[which(rowSums(is.na(dat2)) %in% c(5, 6)),]
dat2$X.4 <- as.numeric((gsub(",", "", dat2$X.4)))
sum(dat2$X.4)/190
#Q3
grep("^United", dat2[,4], value = T)
#Q4
q4url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv"
download.file(q4url, destfile = "./q4data.csv", method = "curl")
dat4 <- read.csv("q4data.csv")
head(dat4)
q4df <- merge(dat4, dat2, 1, 1)
length(grep("^Fiscal year end: June", q4df[,10]))

#Q5
library(quantmod)
amz = getSymbols("AMZN", auto.assign = F)
sampleTimes = index(amz)
sum(format(sampleTimes, format = "%Y") == "2012")
table(weekdays(index(yr2012)))

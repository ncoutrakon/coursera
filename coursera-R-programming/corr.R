#calculates correlation of sulfate and nitrate levels detected by pollutant monitors
#will only include monitors with at least threshold amount of data points
corr <- function (directory, threshold = 0) {
        path <- paste("~/r/coursera-R-programming/", directory,  sep = "")
        docs <- list.files(path)
        pollute.corr <- numeric()
        for (i in docs) {
                loc <- paste(path, "/", i, sep = "")
                dat <- read.table(loc, header = T, sep = ",")
                obs <- sum(complete.cases(dat))
                 if (obs < threshold) {
                         NULL
                 } else {
                        
                        newdat <- dat[complete.cases(dat),]
                        
                        temp.corr <- cor(newdat[,2], newdat[,3])
                        pollute.corr <- c(pollute.corr, temp.corr)
                }
        }
        
        pollute.corr
}
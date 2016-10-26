#given a specific pollutant and directory, will calculate mean of that pollutant detected by all monitors
#each .csv contaings readings from pollutant monitors from past 15yrs
pollutantmean <- function (directory, pollutant, id = 1:332) {
        setwd('~/r/coursera-R-programming')
        result <- numeric()
        pollut.indx <- which(colnames(y) == pollutant)

        for (i in 1:length(id)) {
                if (id[i] < 10) { 
                        newid <- paste("00", id[i], sep = "")
                } else if (id[i] < 100) {
                        newid <- paste("0", id[i], sep = "")
                } else { newid <- id[i]}
                
                loc <- paste(directory, "/", newid, ".csv", sep = "")
                dat <- read.table(loc, header = T, sep = ",")
                
                result <- c(result, dat[,pollut.indx])
        }
        
        mean(result, na.rm = T)
}


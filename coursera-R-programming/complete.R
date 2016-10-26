#filters through all .csv files in a directory
#for each file, prints id of file and number of complete observations in that file


complete <- function (directory, id = 1:332) {
        setwd('~/r/coursera-R-programming')
        complete <- data.frame(id = integer(), nobs = integer())
        results <- numeric()
        
        for (i in 1:length(id)) {
                if (id[i] < 10) { 
                        newid <- paste("00", id[i], sep = "")
                } else if (id[i] < 100) {
                        newid <- paste("0", id[i], sep = "")
                } else { newid <- id[i]}
                
                loc <- paste(directory, "/", newid, ".csv", sep = "")
                dat <- read.table(loc, header = T, sep = ",")
                obs <- sum(complete.cases(dat))
                complete[i,1] <- newid
                complete[i,2] <- obs
        }
        
        complete
}
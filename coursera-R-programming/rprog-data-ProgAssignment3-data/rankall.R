#given a specific outcome and ranking, will return dataframe with each states numth
#best hospital in terms of mortality rates for that outcome

rankall <- function(outcome, num) {
        checkState <- function (df) {
                print (df)
                 if (num == "best") {
                        rnk <- 1
                } else if (num == "worst") {
                        rnk <- nrow(df)
                } else if (num > nrow(df)) {
                        return (NA)
                } else {
                        rnk <- num
                }
    
                return (df[rnk,c(1, 2)])
                
        
        }
        

        hospdf <- read.csv("~/r/rprog-data-ProgAssignment3-data/outcome-of-care-measures.csv", colClasses = "character", stringsAsFactors = F)
        ailments <- list( "heart attack" = 11, "heart failure" = 17, "pneumonia" = 23)
        
        
        if (!(state %in% hospdf$State)) stop("invalid state")
        if (!(outcome %in% names(ailments))) stop("invalid outcome")
                
        hospdf <- hospdf[,c(2, 7, ailments[[outcome]])]
        hospdf <- hospdf[which(!is.na(as.numeric(hospdf[,3]))),]
        hospdf <- hospdf[order(hospdf[2], as.numeric(hospdf[,3]), hospdf[1]),]
        sthosp <- split(hospdf, hospdf[2])
        

        rank <- lapply(sthosp, checkState)
        print (rank)
        retdf <- do.call("rbind",rank)
  
        names(retdf) <- c("hospital", "state")   
       retdf
}
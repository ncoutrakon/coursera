#given a state and an outcome, will return the numth best hospital in that state
#in terms of mortality rates for that specific outcome

rankhospital <- function( state, outcome, num = "best") {
        rnk <- num
        hospdf <- read.csv("~/r/rprog-data-ProgAssignment3-data/outcome-of-care-measures.csv", colClasses = "character", stringsAsFactors = F)
        ailments <- list( "heart attack" = 11, "heart failure" = 17, "pneumonia" = 23)

        if (!(state %in% hospdf$State)) stop("invalid state")
        if (!(outcome %in% names(ailments))) stop("invalid outcome")
        statedf <- hospdf[which(hospdf$State == state), c(2, ailments[[outcome]])]
        statedf <- statedf[which(!is.na(as.numeric(statedf[,2]))),]
        
        
        
        mortrt <- as.numeric(statedf[,2])
        ranked <-order(mortrt, statedf[,1])

        if (num == "best") {
                rnk <- 1
        } else if ( num == "worst") {
                rnk <- length(mortrt)
        } else if ( rnk > length(mortrt)) {
                return (NA)
        }

        hosp <- statedf[ranked[rnk],1]
        hosp
        
}













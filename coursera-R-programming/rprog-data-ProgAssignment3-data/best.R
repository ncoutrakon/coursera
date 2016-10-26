#Reads Outcome-of-Care.csv file provided by the US Dept of Health Human Services
##Given a state and specific outcome, will return character string of the name of the hospital
##with the lowest mortality rate in that state, for that outcome

best <- function(state, outcome) {
        hospdf <- read.csv("~/r/rprog-data-ProgAssignment3-data/outcome-of-care-measures.csv", colClasses = "character", stringsAsFactors = F)
        ailments <- list( "heart attack" = 11, "heart failure" = 17, "pneumonia" = 23)
        
        if (!(state %in% hospdf$State)) stop("invalid state")
        if (!(outcome %in% names(ailments))) stop("invalid outcome")

        statedf <- hospdf[which(hospdf$State == state),]
        mortrt <- as.numeric(statedf[, ailments[[outcome]]])
        minrt <- which(mortrt == min(mortrt, na.rm = T))
        hospnames <- statedf[ minrt, 2]
        
        if (length(minrt) == 1) {
                return (hospnames)
        } else {
                hospnames <- sort(hospnames)
                return (hospnames[1])
        }
        
        
}
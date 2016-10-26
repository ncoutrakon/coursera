library(reshape2)
options(stringsAsFactors = F)
setwd("./coursera-getting-and-cleaning-data/UCI HAR Dataset")
types <- c("test", "train")

activity <- read.table("activity_labels.txt")
features <- read.table("features.txt")

#Reads all tables in train and in test folders and assigns them to a unique variable of the same name
#creates two character vectors which contains the names of each variable, one for test data and one for train data
for (j in types){
        jname <- paste(j,"names",sep="") 
        assign(jname, character())
        for (i in list.files(paste("./",j, sep = ""), "*.txt")){
                x <- basename(i)
                assign(substr(x, 1, nchar(x) - 4),
                       read.table(paste("./", j,"/", i, sep = "")))
                assign(jname, c(get(jname), substr(x, 1, nchar(x) - 4))) 
        }
}

#for the datasets pertaining to trainning set and the testing set, it creates two dataframes
#the first column contains the trial ID number, the second number contains the Activity, and the last 561 columns
#contain the summary data for each participant
for (j in types){
        jname <- get(paste(j,"names",sep=""))
        assign(paste(j, "df", sep=""), cbind(get(jname[1]), get(jname[3]), get(jname[2])))

}

#combines the testing and trainning datasets into one dataframe and names the columns accordingly
        df <- rbind(traindf, testdf)
                colnames(df) <- c("ID", "Activity", features[,2])
        

#pickout which variables are related to the mean and the stdev and
                
        mindex <- grep("mean\\(\\)", features[,2])
        stdindex <- grep("std\\(\\)", features[,2])
        df <- cbind(df[,1:2],df[,mindex + 2], df[,stdindex + 2])
        
#replaces descriptors for the Activity column
        df[,2] <- factor(df[,2], 1:6, activity[,2])
        
#create a new df, avedf, which for each subject and each activity, includes the average
#value for each specific feature
        df <- melt(df, id.vars = c("ID", "Activity"), measure.vars = c(-1,-2))
        avedf <- dcast(df, ID + Activity ~ variable, mean)

#code to export tidy data       
write.table(avedf, file = "tidydata.txt", row.names = F)

#and to export as a csv file if need be
#write.csv(avedf, file = "tidydata.csv", row.names = F)

setwd("~/Coursera/Working_Directory/03_GettingAndCleaningData/GCDProject2020")
library(tidyverse)
Sys.time()
#
# Location of the dataset to be analyzed
#
# https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
#
fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
#
destfile <- "~/Coursera/Working_Directory/03_GettingAndCleaningData/GCDProject2020/GCDProject_2020.zip"
#
# Checking if an archived file already exists.
#
if (!file.exists(destfile)){
      download.file(fileURL, destfile)
      Sys.time()
}  
#
# Checking if dataset folder exists
#
if (!file.exists("UCI HAR Dataset")) { 
      unzip(destfile)
      Sys.time()
}
# 
# Find the files that you want.
#
list_of_files <- list.files("UCI HAR Dataset") %>% print
list_of_test_files <- list.files("UCI HAR Dataset/test") %>% print
list_of_train_files <- list.files("UCI HAR Dataset/train") %>% print
#
activity <- read.table("UCI HAR Dataset/activity_labels.txt", header = FALSE, col.names = c("Code", "Activity"))
features <- read.table("UCI HAR Dataset/features.txt", header = FALSE, col.names = c("Number", "Vector"))
Vector <- features$Vector
#
subject_test <- read.table("UCI HAR Dataset/test/subject_test.txt", header = FALSE, col.names = "Subject")
y_test <- read.table("UCI HAR Dataset/test/Y_test.txt", header = FALSE, col.names = "Code")
x_test <- read.table("UCI HAR Dataset/test/X_test.txt", header = FALSE, col.names = Vector)
SubjectTest <- cbind(y_test,subject_test, x_test)
SubjectTest <- arrange(SubjectTest, Code, Subject)
#
subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt", header = FALSE, col.names = "Subject")
y_train <- read.table("UCI HAR Dataset/train/Y_train.txt", header = FALSE, col.names = "Code")
x_train <- read.table("UCI HAR Dataset/train/X_train.txt", header = FALSE, col.names = Vector)
SubjectTrain <- cbind(y_train,subject_train, x_train)
SubjectTrain <- arrange(SubjectTrain, Code, SubjectTrain)
#
# Write the two datasets to file.
#
write.csv(SubjectTest, "SubjectTest.csv", row.names = FALSE)
write.csv(SubjectTrain, "SubjectTrain.csv", row.names = FALSE)
#
# Combine test file and train(ing) file
# Merge the combined file with the activity file
# Rearrange the columns: "Subject, Code, Activity" ....
# Arrange the file according to "Code ==> Subject"
#
SubjectTestTrain <- rbind(SubjectTest, SubjectTrain)
SubjectTestTrain <- merge(SubjectTestTrain, activity, by = "Code")
SubjectTestTrain <- SubjectTestTrain[, c(1, 2, 564, 3:563)]
SubjectTestTrain <- arrange(SubjectTestTrain, Code, Subject)
write.csv(SubjectTestTrain, "SubjectTestTrain.csv", row.names = FALSE)
ColumnNames <- colnames(SubjectTestTrain)
LengthColumnNames <- c(1:(length(ColumnNames)))
SubjectTestTrain_Vector <- as.data.frame(cbind(LengthColumnNames, ColumnNames))
write.csv(SubjectTestTrain_Vector, "SubjectTestTrain_Vector.csv",  row.names = FALSE)
#
# Descriptive Titles:
#
Features <- features$Vector
Features <- gsub("BodyBody", "Body", Features, ignore.case = TRUE)
Features <- gsub("[gG}]yro", "Gyroscope", Features, ignore.case = TRUE)
Features <- gsub("Acc", "Accelerometer", Features, ignore.case = TRUE)
Features <- gsub("fBody", "FrequencyBody", Features, ignore.case = TRUE)
Features <- gsub("tBody", "TimeBody", Features, ignore.case = TRUE)
Features <- gsub("tGravity", "TimeGravity", Features, ignore.case = TRUE)
Features <- gsub("meanFreq", "meanFrequency", Features, ignore.case = TRUE)
Features <- gsub("JerkMean),gravityMean)", "JerkMean,gravityMean)", Features, ignore.case = TRUE)
Features <- gsub("Mag", "Magnitude", Features, ignore.case = TRUE)
Features <- gsub("meterMean,gravity", "meterMean,gravityMean", Features, ignore.case = TRUE)
Features <- gsub("sma", "SignalMagnitudeArea", Features, ignore.case = TRUE)
Features <- gsub("iqr", "InterquartileRange", Features, ignore.case = TRUE)
Features <- gsub("maxInds", "MaximumFrequencyMagnitudeIndex", Features, ignore.case = TRUE)
Features <- gsub("-mean", "Mean", Features,  ignore.case = TRUE)
Features <- gsub("-std", "Std", Features,  ignore.case = TRUE)
Features <- gsub("angle", "Angle", Features,  ignore.case = TRUE)
Features <- gsub("gravity", "Gravity", Features,  ignore.case = TRUE)
Features <- gsub("mad", "Median_Absolute_Deviation", Features,  ignore.case = TRUE)
write.table(Features, "Features_1.txt")
ColumnNames <- c("Code", "Subject", "Activity", Features)
SubjectTestTrain_Vector_New <- as.data.frame(cbind(LengthColumnNames, ColumnNames))
write.csv(SubjectTestTrain_Vector_New, "SubjectTestTrain_Vector_New.csv", row.names = FALSE)
colnames(SubjectTestTrain) <- ColumnNames
ComparisonColumnNames <- merge(SubjectTestTrain_Vector, SubjectTestTrain_Vector_New, by="LengthColumnNames")
ColumnNames1 <- c("LengthColumnNames", "SubjectTestTrain_Vector", "SubjectTestTrain_Vector_New")
colnames(ComparisonColumnNames) <- ColumnNames1
ComparisonColumnNames <- as.data.frame(ComparisonColumnNames)
ComparisonColumnNames$LengthColumnNames <- as.integer(ComparisonColumnNames$LengthColumnNames)
ComparisonColumnNames <- arrange(ComparisonColumnNames, LengthColumnNames)
write.csv(ComparisonColumnNames, "ComparisonColumnNames.csv", row.names = FALSE)
#
# Create "TidyData_1" 
#` `
MSD <- SubjectTestTrain %>% select(contains("Mean"), contains("Std"))
TidyData_1 <- cbind(SubjectTestTrain[, 1:3], MSD)
TidyData_1 <- arrange(TidyData_1, Code, Subject)
write.csv(TidyData_1, "TidyData_1.csv", row.names = FALSE)
TidyData_Vector <- colnames(TidyData_1)
LengthTidyData_Vector <- c(1:(length(TidyData_Vector)))
TidyData_Vector <- as.data.frame(cbind(LengthTidyData_Vector, TidyData_Vector))
write.csv(TidyData_Vector, "TidyData_Vector.csv", row.names = FALSE)
#
# Create "TidyData 2"
#
TidyData_2 <- TidyData_1 %>%
      group_by(Subject, Activity) %>%
      summarise_all(list(mean))
TidyData_2 <- arrange(TidyData_2, Subject, Code)      
write.csv(TidyData_2, "TidyData_2.csv", row.names = FALSE)
#
# End



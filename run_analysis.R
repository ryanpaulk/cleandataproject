## You should create one R script called run_analysis.R that does the following. 
path <- getwd()
url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
if (!file.exists("Zip.zip")) {
  download.file(url, file.path(path, "Zip.zip"))
}
unzip(zipfile = "Zip.zip")
setwd("./UCI HAR Dataset")



## From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
## Good luck!
library(data.table)
library(tidyr)
library(dplyr)

## Read the Data
## Appropriately labels the data set with descriptive variable names. 
features <- read.table("features.txt")
activitylabels <- fread("activity_labels.txt", col.names = c("Integer", "Activity"))

x_test <- fread("test/x_test.txt", col.names = as.character(features[,2])) ##adds features as column names
y_test <- fread("test/y_test.txt", col.names = "Activity")
subject_test <- fread("test/subject_test.txt", col.names = "Subject")
test <- cbind(subject_test, y_test, x_test) ## Combine with Subject, Activity, and Measurement

x_train <- fread("train/x_train.txt", col.names = as.character(features[,2]))
y_train <- fread("train/y_train.txt", col.names = "Activity")
subject_train <- fread("train/subject_train.txt", col.names = "Subject")
train <- cbind(subject_train, y_train, x_train)

## Merges the training and the test sets to create one data set.
## --- test + train should have 2947 + 7352 = 10299 rows
## -- rbind!
data <- rbind(test, train)

## Extracts only the measurements on the mean and standard deviation for each measurement. 
## --- something with grep("mean", features[,2]) and grep("std", features[,2])
## --- make that names(), all the column names that match either "mean" or "std"
## --- should reduce features from 561 to ~ 70) // Now 563 to ~72 == 81
## --- subset by the grep
## --- select function needed from dplyr
meanstd <- select(data, grep("Subject|Activity|mean|std", names(data)))

## Uses descriptive activity names to name the activities in the data set
## --- transpose activitylabels' Integers to Activity, renaming everything in the column
## --- Tidy up Column names with gsub
meanstd[["Activity"]] <- factor(meanstd$Activity, levels = activitylabels$Integer, labels = activitylabels$Activity)
names(meanstd) <- gsub("^t", "Time", names(meanstd))
names(meanstd) <- gsub("Acc", "Accelerometer", names(meanstd))
names(meanstd) <- gsub("Gyro", "Gyroscope", names(meanstd))
names(meanstd) <- gsub("Mag", "Magnitude", names(meanstd))
names(meanstd) <- gsub("^f", "Frequency", names(meanstd))
names(meanstd) <- gsub("\\(\\)", "", names(meanstd))
names(meanstd) <- gsub("-", "_", names(meanstd))
names(meanstd) <- gsub("BodyBody", "Body", names(meanstd))
## From the data set in step 4, creates a second, independent tidy data set
## with the average of each variable for each activity and each subject.
## --- Group them! Subject's Activities's Feature Averaged
grouped <- group_by(meanstd, Subject, Activity)
Average <- summarise_all(grouped, mean, na.rm = TRUE)

fwrite(Average, file = "TidyData.txt", row.name = FALSE)
## You should create one R script called run_analysis.R that does the following. 




## From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
## Good luck!
library(data.table)
library(tidyr)
library(reshape2)
library(dplyr)
setwd("C:/Users/Ryan.Paulk/Documents/Data Science/datasciencecoursera/DataCleaning/Week4/UCI HAR Dataset")
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

meanstd[["Activity"]] <- factor(meanstd$Activity, levels = activitylabels$Integer, labels = activitylabels$Activity)

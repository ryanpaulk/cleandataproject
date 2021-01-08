## You should create one R script called run_analysis.R that does the following. 

## Merges the training and the test sets to create one data set.
## Extracts only the measurements on the mean and standard deviation for each measurement. 
## --- something with grep("mean", features[,2]) and grep("std", features[,2])
## --- should reduce features from 561 to ~ 70)
## Uses descriptive activity names to name the activities in the data set
## Appropriately labels the data set with descriptive variable names. 
## From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
## Good luck!
library(data.table)
library(tidyr)
library(reshape2)
setwd("C:/Users/Ryan.Paulk/Documents/Data Science/datasciencecoursera/DataCleaning/Week4/UCI HAR Dataset")
## Read the Data
features <- read.table("features.txt")
activity <- read.table("activity_labels.txt")
activitylabels <- fread("activity_labels.txt", col.names = c("Integer", "Activity"))

x_test <- fread("test/x_test.txt", col.names = as.character(features[,2])) ##adds features as column names
y_test <- fread("test/y_test.txt", col.names = "Activity")
subject_test <- fread("test/subject_test.txt", col.names = "Subject")

x_train <- fread("train/x_train.txt", col.names = as.character(features[,2]))
y_train <- fread("train/y_train.txt", col.names = "Activity")
subject_train <- fread("train/subject_train.txt", col.names = "Subject")
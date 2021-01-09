## 1. Download and unzip the files 
path <- getwd()
url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
if (!file.exists("Zip.zip")) {
  download.file(url, file.path(path, "Zip.zip"))
}
unzip(zipfile = "Zip.zip")
setwd("./UCI HAR Dataset")

library(data.table)
library(tidyr)
library(dplyr)

## 2.Read the Data
## Appropriately label the data set with descriptive variable names. 
features <- read.table("features.txt")
activitylabels <- fread("activity_labels.txt", col.names = c("Integer", "Activity"))

x_test <- fread("test/x_test.txt", col.names = as.character(features[,2])) 
y_test <- fread("test/y_test.txt", col.names = "Activity")
subject_test <- fread("test/subject_test.txt", col.names = "Subject")
test <- cbind(subject_test, y_test, x_test) 

x_train <- fread("train/x_train.txt", col.names = as.character(features[,2]))
y_train <- fread("train/y_train.txt", col.names = "Activity")
subject_train <- fread("train/subject_train.txt", col.names = "Subject")
train <- cbind(subject_train, y_train, x_train)

## 3. Merge the training and the test sets to create one data set.

data <- rbind(test, train)

## 4. Extract only the measurements on the mean and standard deviation for each measurement. 

meanstd <- select(data, grep("Subject|Activity|mean|std", names(data)))

## 5. Use descriptive activity names to name the activities in the data set

meanstd[["Activity"]] <- factor(meanstd$Activity, levels = activitylabels$Integer,
                                labels = activitylabels$Activity)
names(meanstd) <- gsub("^t", "Time", names(meanstd))
names(meanstd) <- gsub("Acc", "Accelerometer", names(meanstd))
names(meanstd) <- gsub("Gyro", "Gyroscope", names(meanstd))
names(meanstd) <- gsub("Mag", "Magnitude", names(meanstd))
names(meanstd) <- gsub("^f", "Frequency", names(meanstd))
names(meanstd) <- gsub("\\(\\)", "", names(meanstd))
names(meanstd) <- gsub("-", "_", names(meanstd))
names(meanstd) <- gsub("BodyBody", "Body", names(meanstd))
## 6. Create a second, independent tidy data set with the average of each 
##    variable for each activity and each subject.

grouped <- group_by(meanstd, Subject, Activity)
Average <- summarise_all(grouped, mean, na.rm = TRUE)

fwrite(Average, file = "TidyData.txt", row.name = FALSE)
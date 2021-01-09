
## Codebook

## Functions and Transformations used to clean up the data

1. Download the data locally and unzip
2. Load relevant libraries: dplyr, tidyr, data.table
3. Read data with fread() and assign variables
4. Create Labels for Columns from Features file with fread()
5. Label the Activites from Activity Label file with factor()
6. Combine Test data files with cbind()
7. Combine Training data files with cbind()
8. Combine Test and Training data files with rbind(). 
9. Subset the data to only the mean and std measurements by using select() and grep()
10. Clean the column labels with gsub()
11. Group and average the subsetted data of each Subject's Activity's measurements using group_by() and then summarise_all()
12. Produce a text file of the summarised data from 11 using fwrite()

## Variables Defined

features: The column names of measured feature

activitylabels: The activity performed

x_test: The metrics recorded

y_test: The activities that each subject performed

subject_test: The subjects that performed each activity

test: The combination of the Test data

x_train: The metrics recorded

y_train: The activities that each Subject performed

subject_train: The subjects that performed each activity

train: the combination of the Training data

data: the combination of the Test and Train data sets

meanstd: The subset of the Means and Standard Deviations of the Test and            Train data sets

grouped: Grouping of each Subject's Activity's Feature measurement

Average: Averaging the groups of measurements for each Subject's Activity's          Feature



---
title: Code Book for "run_analysis.R"
author: Shenay
date: 2019/5/26
---

## Project Description
The goal of this project is to test our ability to acquire and clean data sets that will be used for future analysis.

It will be graded on the following criteria:
  1. The submitted data set is tidy
  2. The Github repo contains the required scripts
  3. Github contains a code book that modifies and updates the available codebooks with the data to indicate all the variables and summaries calculated, along with units, and other relevant information
  4. The work submitted is the work of the student who submitted it

## Creating the tidyData file
Step 0: Load necessary data files into R, including X_train, y_train, subject_train, X_test, y_test, and subject_test
Step 1: Merge the training and test files to generate an 10299-by-2 dimension data frame
Step 2: Per instructions, extract only the mean and standard deviation for each measurement (180-by-6 dimension)
Step 3: According to the activity_labels, subject_train, and subject_test.txt files, re-name the respective columns for subject ID and activity type
Step 4: Based on the features.txt file, label the remaining columns using descriptive variable names
Step 5: Leveraging the merged and cleaned data set, create another independent tidy data set with the average of each variable for each activity and each subject

## Description of the identifier variables
* Subject   -    ID number of the individual, between 1 and 30
* Activity  -   Type of activity, between 1 and 6

## Description of the measurement variables
Among the list of 561 vector variables that were collected in the study, we will assume that the mean and standard deviation
for the following variables below are sufficient:

* tBodyAcc-XYZ
* tGravityAcc-XYZ
* tBodyAccJerk-XYZ
* tBodyGyro-XYZ
* tBodyGyroJerk-XYZ
* tBodyAccMag
* tGravityAccMag
* tBodyAccJerkMag
* tBodyGyroMag
* tBodyGyroJerkMag
* fBodyAcc-XYZ
* fBodyAccJerk-XYZ
* fBodyGyro-XYZ
* fBodyAccMag
* fBodyAccJerkMag
* fBodyGyroMag
* fBodyGyroJerkMag

NOTE: By assumption, the mean and standard deviation of the following variables were not extracted:
* gravityMean
* tBodyAccMean
* tBodyAccJerkMean
* tBodyGyroMean
* tBodyGyroJerkMean

## Description of the activity labels

* 1 Walking
* 2 Walking_Upstairs
* 3 Walking_Downstairs
* 4 Sitting
* 5 Standing
* 6 Laying

## Link to database
http://archive.ics.uci.edu/ml/machine-learning-databases/00240/

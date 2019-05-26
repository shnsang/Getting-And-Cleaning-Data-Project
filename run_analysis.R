#==================================
#
# Getting and Cleaning Data Project
#
#==================================

library(data.table)
library(reshape2)
library(dplyr)

# Read training, test, and subject data sets--our goal is to find their intersection

if (!file.exists("./data")) {dir.create("./data")}
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileUrl, destfile = "./data/getdata_projectfiles_UCI HAR Dataset")

zip <- unzip("./data/projectData_getCleanData.zip", exdir = "./data")

train_X <- read.table("./data/UCI HAR Dataset/train/X_train.txt")
train_y <- read.table("./data/UCI HAR Dataset/train/y_train.txt")
train_subject <- read.table("./data/UCI HAR Dataset/train/subject_train.txt")
test_X <- read.table("./data/UCI HAR Dataset/test/X_test.txt")
test_y <- read.table("./data/UCI HAR Dataset/test/y_test.txt")
test_subject <- read.table("./data/UCI HAR Dataset/test/subject_test.txt")
features <- read.table("./data/UCI HAR Dataset/features.txt")

str(features)
features <- transpose(features)  #transpose for later use

# Look at the data in more detail--within training and test data sets, there are 7532 
# observations and 561 activity instances
str(train_X)
str(train_y)
str(train_subject)
str(test_X)
str(test_y)
str(test_subject)

# Merge training and test data sets--stack test after train via column names V1:V561,
# do similarly for subject and y variables in the other two columns based on V1
names(train_X)
names(train_y)
names(train_subject)
names(test_X)
names(test_y)
names(test_subject)
names(features)

mergedX <- rbind(train_X, test_X)
mergedY <- rbind(train_y, test_y)
mergedS <- rbind(train_subject, test_subject)
mergedData <- cbind(mergedS, mergedY, mergedX)

# Label the columns using appropriate variable names
features[c("A", "B")] <- NA  #add two blank columns to features (match column of 563)

features <- features %>% select("A", "B", everything()) #swap blank columns to the beginning

colnames(mergedData) <- features[1, ]  #assign features as proper column names for merged data
colnames(mergedData)[1] <- "Subject"
colnames(mergedData)[2] <- "Activity"

index <- grep(("mean\\(\\)|std\\(\\)"), names(mergedData))  #total of 66 matches for mean and std
mergedData <- mergedData[, c(1, 2, index)]  #only mean and std columns are extracted

# Replace numbers 1-6 in the activity column with descriptive labels 
#1=Walking, 2=Walking_Upstairs, 3=Walking_Downstairs, 4=Sitting, 5=Standing, 6=Laying

factor(mergedData$Activity, levels = c(1, 2, 3, 4, 5, 6), labels = c("Walking",
        "Walking_Upstairs", "Walking_Downstairs", "Sitting", "Standing", "Laying"))

# In order to satisfy the three principles of tidy data, need to group by subject/activity pairs
tidyData <- mergedData %>% 
        group_by(Subject, Activity) %>%
        summarize_each(funs(mean))
str(tidyData)  #180 observations of 68 variables

# Export tidy data set in txt format
write.table(tidyData, file = "tidyData.txt")

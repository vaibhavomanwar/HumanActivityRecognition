# Title: Script for generating tidy data for Human Activity Recognition dataset
# Filename: run_analysis.R
# Author: Vaibhav Omanwar <vaibhavomanwar@gmail.com>
# Description: 
# This script generats tidy data from 'Human Activity Recognition Using 
# Smartphones Dataset'.
# The original dataset is created by Smartlab, Università degli Studi di Genova.
# Please refer to README.md for details.
# Created on: R (3.1.0)
# Pre-requisites: 'data' directoy
#	This script assumes uncompressed format of original dataset be
#	present in "data" folder in same directory as of this file.

# Check if data present
if(!file.exists("./data")){warning("Data dir absent")}

# Read data from data directory
# Read test data
x.test <- read.table("./data/test//X_test.txt")
y.test <- read.table("./data/test//y_test.txt")
subject.test <- read.table("./data/test//subject_test.txt")
colnames(subject.test) <- "subject"
# Read train data
x.train <- read.table("./data/train//X_train.txt")
y.train <- read.table("./data/train//y_train.txt")
subject.train <- read.table("./data/train//subject_train.txt")
colnames(subject.train) <- "subject"

# Merge train and test data
masterdb <- rbind(x.train, x.test)

# Read features LUT
features <- read.table("./data/features.txt")
colnames(features) = c("colindex", "oldfeatname")

# Modify old feature names 
features$newfeatname <- gsub(")-", "", features$oldfeatname)
features$newfeatname <- gsub(")", "", features$newfeatname)
features$newfeatname <- gsub("\\(", "", features$newfeatname)
# Remove errors in feature varaible names
features$newfeatname <- gsub("BodyBody", "Body", features$newfeatname)
colnames(masterdb) <- features$newfeatname

# Assign column names
names(masterdb) <- tolower(names(masterdb))

# Extract only mean and std features
features$mean <- grepl("mean()", features$oldfeatname)
features$std <- grepl("std()", features$oldfeatname)

# Remove meanFreq featues
features$meanFreq <- grepl("meanFreq()", features$oldfeatname)
features$extract <- (features$mean | features$std) & !features$meanFreq
col.extract <- subset(features$colindex, features$extract)
masterdb <- masterdb[,col.extract]

# Label activities
activityLUT <- read.table("./data/activity_labels.txt")
colnames(activityLUT) <- c("value", "activity")
activityLUT$value <- factor(activityLUT$value)
activity <- rbind(y.train, y.test)
names(activity) = "activity"
activity$activity <- factor(activity$activity, labels = activityLUT$activity)
masterdb <- cbind(masterdb, activity, rbind(subject.train, subject.test))

# Summerize tidy data
# Calculate mean of all remaining variables
require(plyr)
drops = c("activity", "subject")
data.columns = !(colnames(masterdb) %in% drops)
tidy_data <- ddply(masterdb, .(activity, subject), 
                   function(x) colMeans(x[data.columns]))

# Count frequency of no of observations for each activity & each subject
observation.freq <- ddply(masterdb, .(activity, subject), summarize, 
                     frequency = length(subject))
frequency <- observation.freq$frequency
target.position <- which(names(tidy_data) == 'subject')[1]
tidy_data <- cbind(tidy_data[, 1 : target.position, drop = F], frequency, 
                   tidy_data[, (target.position + 1): length(tidy_data), drop = F])

# Write tidy to a .txt file
write.table(tidy_data, "tidy_data.txt")
# End of file
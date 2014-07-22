# Human Activity Recognition using Smartphone Tidy Dataset

_Author:Vaibhav Omanwar <vaibhavomanwar@gmail.com>_
_Coursera - Getting and Cleaning Data_

## Project
This project is a part of course work for the course - Getting and Cleaning Data run by John Hopkins University through Coursera Inc. The aim of this project is to create a tidy dataset for human activity recognition using smartphones. The original raw dataset was captured by Jorge et. all at Smartlab, Università degli Studi di Genova. 

## Dataset
The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz were captured.

### The Raw Data
The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. Subsequently, the body linear acceleration and angular velocity were derived in time to obtain Jerk signals (tBodyAccJerk-XYZ and tBodyGyroJerk-XYZ). Also the magnitude of these three-dimensional signals were calculated using the Euclidean norm (tBodyAccMag, tGravityAccMag, tBodyAccJerkMag, tBodyGyroMag, tBodyGyroJerkMag). Fast Fourier Transform (FFT) was applied to some of these signals producing fBodyAcc-XYZ, fBodyAccJerk-XYZ, fBodyGyro-XYZ, fBodyAccJerkMag, fBodyGyroMag, fBodyGyroJerkMag. (Note the 'f' to indicate frequency domain signals). Variables like mean and standard deviation were applied on each of these signals. A full description is available at the site where the data was obtained:
[HumanActivityRecognitionDataset](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones).

### The Tidy Data
Only mean and standard deviation variables applied on every measurement were considered for tidy dataset. Tidy dataset is captured by avaeraging each variable for each activity and each subject. There are 30 subject performing 6 different types of activities producing 180 combinations representing the measurements. Please refer to codebook.md file for description of each variable.

## Files Structure
The dataset contains following files.
* README.md
* 'tidy_data.txt': Tidy dataset generated using 'run_analysis.R' contains header, every row represents a measurement
* 'CODEBOOK.md': Description of all variables
* 'run_analysis.R': Script to obtain tidy data from raw data.
* 'data/features_info.txt': Shows information about the variables used on the feature vector.
* 'data/features.txt': List of all features.
* 'data/activity_labels.txt': Links the class labels with their activity name.
* 'data/train/X_train.txt': Training set.
* 'data/train/y_train.txt': Training labels.
* 'data/test/X_test.txt': Test set.
* 'data/test/y_test.txt': Test labels.
* 'data/train/subject_train.txt': Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30.
* 'data/test/subject_test.txt': Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30.
	
## Script
The script 'run_analysis.R' generates tidy data from original raw dataset. First of all training and test files are read and merged producing a big dataset. The feature descriptions from 'data/features.txt' are used to assign feature names to merged dataset. Subsequently only mean and std variables are extracted. However there are some 'meanFreq' variables present which may not be of interest removed from extracted dataset. Descriptive labels are assigned for all activities. The activity description os present in 'data/activity_labels.txt' file. Finally the merged dataset is summerized by estimating the column means for each activity for each subject. Also a 'frequency' variable is added counting the occurances of all combinations.
### Inputs
	'data/features.txt', 'data/activity_labels.txt', 'data/train/X_train.txt', 'data/train/y_train.txt', 'data/test/X_test.txt', 'data/test/y_test.txt', 'data/test/subject_test.txt', 'data/train/subject_train.txt'
### Output
	'tidy_data.txt': Tidy dataset contains header, every row represents a measurement.
	Please refer to 'CODEBOOK.md' for description of all variables.



##Getting-and-Cleaning-Data
===========================
###Raw Data
===========================

Data collected from the accelerometers from the Samsung Galaxy S smartphone

* File Link: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
* Source: http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

###Tidy Data
==========================

To create one R script called run_analysis.R that does the following. Merges the training and the test sets to create one data set. Extracts only the measurements on the mean and standard deviation for each measurement. Uses descriptive activity names to name the activities in the data set Appropriately labels the data set with descriptive activity names. Creates a second, independent tidy data set with the average of each variable for each activity and each subject.

* File Link: https://github.com/subhashinig/Getting-and-Cleaning-Data/blob/master/tidydata.txt

###Code Book
=========================

* File Link: https://github.com/subhashinig/Getting-and-Cleaning-Data/blob/master/CodeBook.md

###R Script for analysis and Steps to reproduce
=========================

* File Link: https://github.com/subhashinig/Getting-and-Cleaning-Data/blob/master/run_analysis.R

1. Loading reshape2
2. Setting Working Space
3. Uploading files,
  * X_test.txt
  * X_train.txt
  * y_test.txt
  * y_train.txt
  * subject_test.txt
  * subject_train.txt
  * features.txt
4. Merging training and test files (X files) using merge
5. Setting Column names for all features variables
6. Merging training and test files (Y files) using row bind
7. Merging training and test files (subject_ files) using row bind
8. Merging (X,Y,subject_)files using cbind
9. Finding column names with "Mean" and "Std"
10. Subsetting the values for AvtivityID
11. Re-ordering the columns and assigning labels
12. Melting for preparing TIDY Data for upload, using melt function
13. Writing to text file for upload

###Reference
========================

[1] Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly Support Vector Machine. International Workshop of Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012

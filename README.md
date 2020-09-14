Getting and Cleaning Data Course Project 
The purpose of this project is to demonstrate our ability to collect, work with,
and clean a data set. The goal is to prepare tidy data that can be used for later
analysis. To this end we will download data collected from the accelerometers of 
the Samsung Galaxy S smartphone. 

A full description is available at the site where the data was obtained:
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

The dataset for this project:
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
The UCI HAR Dataset provides a thorough description of the dataset that we will be
analyzing.

Objectives
    Create one R script called run_analysis.R that does the following:
      .	Merges the training set (SubjectTrain) and the test set (Subject Test) 
            to create one data set (SubjetTestTrain).
      .	Uses descriptive activity names to name the activities in the data 
            set (SubjectTestTrain_Vector_New).
      .	Appropriately labels the data set with descriptive variable names.
      .	Create a tidy data set (TidyData_1) that extracts only the 
            measurements on the mean and standard deviation for each measurement.
      .	Create a second tidy data set (TidyData_2) with the average of each 
            variable for each activity and each subject.

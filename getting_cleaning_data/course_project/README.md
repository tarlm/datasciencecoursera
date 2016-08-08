# Course Project of Getting and Cleaning Data
The repo hosts mu submission for project of Johns Hopkins Getting and Cleaning Data course located on Coursera.

## Summary

The purpose of this project is to demonstrate the ability to collect, work with, and clean a data set. The goal is to prepare tidy data that can be used for later analysis. 

* CodeBook.md: describe key variables, and type of measurements
* run_analysis.R: contains all code used to handle the assignment. No prerequisite need to run the script. The script handle all stuff: folder creation, file download and data processing. Just download the script and run it from RStudio. 

## My analysis steps

PS: 

1. I first created a data folder in which the resources (the zip file) needed for the analysis will be downloaded 
2. Download the zip file if not download already. The goal is to not download again
3. Unzip the downloaded file if not done already
4. Loads both the training and test datasets, merge data into four big data sets: 
    * 'subject_full_data': contains 100% of train and test subjects observations
    * 'x_full_data': contains 100% of train and test acceleration and deviation data
    * 'y_full_data': contains 100% of train and test activity's data
    * 'full_data':  concatenate full data from subject, x_full and y_full
5. Keep only the columns which reflect a mean or standard deviation in the final data set 'full_data'
6. Uses descriptive activity names to name the activities in the final data set
7. Appropriately labels the data set with descriptive variable names by getting those names from 'features.txt'.
8. Create a second, independent tidy data set from the final data set 'full_data' previously created with the average of each variable for each activity and each subject. 

The result, tidy data set is named "average_tidy_data.txt"
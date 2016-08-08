# Course Project of Getting and Cleaning Data
The repo hosts mu submission for project of Johns Hopkins Getting and Cleaning Data course located on Coursera.

## summary

This pro

## My analysis steps

1. I first created a data folder in which the resources (the zip file) needed for the analysis will be downloaded 
2. Download the zip file if not download already. The goal is to not download again
3. Unzip the downloaded file if not done already
4. Loads both the training and test datasets, merge data into for big data set: 
    * 'subject_full_data': contains 100% of train and test subjects observations
    * 'x_full_data': contains 100% of train and test acceleration and deviation data
    * 'y_full_data': contains 100% of train and test activity's data
    * 'full_data':  concatenate full data from subject, x_full and y_full
5. keeping only those columns which reflect a mean or standard deviation
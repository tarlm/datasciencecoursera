#################################################################################
# title: "gc_course_project"
# author: "Rodrigue ADOUHOUEKONOU"
# descruption: "Script used to handle the quiz of getting and cleaning data module of week 3"
# date: "07 AOut 2016"
#################################################################################

require(dplyr)


setwd("./getting_cleaning_data/course_project/") # first set my working directory

# create data folder if not exist in order to store all ressources needed for the project
if(!file.exists("./data")){
    dir.create("./data")
}

# initiate my data folder path variable. Will be used in the whole project for data manip
data_fld_path <- file.path(getwd(), "data/")

zip_filename<- file.path(data_fld_path, "files_FUCI_HAR_Dataset.zip") # set file_path on system

# Download this zip file if not exist already
if(!file.exists(zip_filename)){
    file_url <- 
        "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
    download.file(file_url, zip_filename, mode = "wb" , method = "libcurl")
}

my_dataset_fld <- file.path(data_fld_path, "UCI HAR Dataset") # folder used to handle my dataset

# Unzip the dataset if not done already
if (!file.exists(my_dataset_fld)) { 
    unzip(zip_filename, exdir = data_fld_path)
}

# Load activity labels + features
activity_labels <- 
    read.table(file.path(my_dataset_fld,"activity_labels.txt"), stringsAsFactors = FALSE)

features <- read.table(file.path(my_dataset_fld,"features.txt"), stringsAsFactors = FALSE)

### 1. Merges the training and the test sets to create one data set. ###
### 2. Extracts only the measurements on the mean and standard deviation for each measurement. ###
### 3. Uses descriptive activity names to name the activities in the data set ###
### 4. Appropriately labels the data set with descriptive variable names. ###
### 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject. ###
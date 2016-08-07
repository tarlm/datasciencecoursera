#################################################################################
# title: "gc_course_project"
# author: "Rodrigue ADOUHOUEKONOU"
# descruption: "Script used to handle the quiz of getting and cleaning data module of week 3"
# date: "07 AOut 2016"
#################################################################################

require(dplyr)

# Step0 : Setup the working environnement and varibles 
###############################################################################

setwd("./getting_cleaning_data/course_project/") # first set my working directory

# Clean up workspace
rm(list=ls())

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

# Step1 : Merges the training and the test sets to create one data set. 
###############################################################################

# Load common data: activity labels + features
activity_labels <- 
    read.table(file.path(my_dataset_fld,"activity_labels.txt"), stringsAsFactors = FALSE)

features <- read.table(file.path(my_dataset_fld,"features.txt"), stringsAsFactors = FALSE)

# Load train data counts for 70% of observations: X_train.txt, y_train.txt, subject_train.txt
x_train <- read.table(file.path(my_dataset_fld,"train/X_train.txt"), stringsAsFactors = FALSE)
y_train <- read.table(file.path(my_dataset_fld,"train/y_train.txt"), stringsAsFactors = FALSE)
subject_train <- read.table(file.path(my_dataset_fld,"train/subject_train.txt"), stringsAsFactors = FALSE)

# Load text data counts for 30% of observations: X_test.txt, y_test.txt, subject_test.txt
x_test <- read.table(file.path(my_dataset_fld,"test/X_test.txt"), stringsAsFactors = FALSE)
y_test <- read.table(file.path(my_dataset_fld,"test/y_test.txt"), stringsAsFactors = FALSE)
subject_test <- read.table(file.path(my_dataset_fld,"test/subject_test.txt"), stringsAsFactors = FALSE)

#### Below are the requested data set ####

# Merge 'x' datas(train and test) in order to 100% of 'X' observations
x_full_data <- rbind(x_train, x_test)

# Merge 'y' datas(train and test) in order to 100% of 'Y' observations
y_full_data <- rbind(y_train, y_test)

# Merge 'subject' datas(train and test) in order to 100% of 'subject' observations
subject_full_data <- rbind(subject_train, subject_test)


# Step2. Extracts only the measurements on the mean and standard deviation for each measurement.
###############################################################################




# Step3. Uses descriptive activity names to name the activities in the data set
###############################################################################


# Step4. Appropriately labels the data set with descriptive variable names.
###############################################################################


# Step5. From the data set in step 4, creates a second, independent tidy data set 
# with the average of each variable for each activity and each subject.
###############################################################################


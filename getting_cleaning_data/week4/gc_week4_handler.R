#################################################################################
# title: "gc_week4_handler"
# author: "Rodrigue ADOUHOUEKONOU"
# descruption: "Script used to handle getting and cleaning data module of week 4"
# date: "21 juillet 2016"
#################################################################################

# require() placeholder


setwd("./getting_cleaning_data/week4/") # first set my working directory

# Create data folder if not exist
if(!file.exists("./data")){
    dir.create("./data")
}


######## Chap1:  ########
#
# Just listening 

######## Chap2:  ########
#
# The URL used to download data is 
# https://data.baltimorecity.gov/api/views/k5ry-ef3g/rows.csv?accessType=DOWNLOAD  
# 

fileUrl <- "https://data.baltimorecity.gov/api/views/k5ry-ef3g/rows.csv?accessType=DOWNLOAD"
file_path <- file.path(getwd(), "data/getdatajeff.jpg")
download.file(jpeg_url, file_path, mode = "wb" , method = "libcurl")

# method = "libcurl" or "wininet" for windows machine
#download.file(fileUrl, destfile = "./data/restaurants.csv", method = "curl")
download.file(fileUrl, destfile = "./data/restaurants.csv", method = "wininet")

restData <- read.csv("./data/restaurants.csv")


# Check for missing values

######## Chap3:  ########




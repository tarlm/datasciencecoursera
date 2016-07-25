#################################################################################
# title: "gc_week3_handler"
# author: "Rodrigue ADOUHOUEKONOU"
# descruption: "Script used to handle getting and cleaning data module of week 3"
# date: "21 juillet 2016"
#################################################################################

# require() placeholder


######## Chap1: Subsetting and Sorting ########
#
# Just listening 

######## Chap2: Summarizing Data ########
#
# The URL used to download data is 
# https://data.baltimorecity.gov/api/views/k5ry-ef3g/rows.csv?accessType=DOWNLOAD  
# 

setwd("C:/Users/VV5193/Local/Data/DevSpace/RSpace/datasciencecoursera/getting_cleaning_data/week3/")

# Getting data from the web


if(!file.exists("./data")){
    dir.create("./data")
}

fileUrl <- "https://data.baltimorecity.gov/api/views/k5ry-ef3g/rows.csv?accessType=DOWNLOAD"

# method = "libcurl" for windows machine
#download.file(fileUrl, destfile = "./data/restaurants.csv", method = "curl")
download.file(fileUrl, destfile = "./data/restaurants.csv", method = "libcurl")

restData <- read.csv("./data/restaurants.csv")

# look at a bit of the data 
head(restData, n = 3) # the top 3

tail(restData, n = 3) # the buttom 3

summary(restData)

str(restData)

quantile(restData$councilDistrict, na.rm = TRUE)
quantile(restData$councilDistrict, probs = c(0.5, 0.75, 0.9))
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

setwd("./getting_cleaning_data/week3/")

# Getting data from the web


if(!file.exists("./data")){
    dir.create("./data")
}

fileUrl <- "https://data.baltimorecity.gov/api/views/k5ry-ef3g/rows.csv?accessType=DOWNLOAD"

# method = "libcurl" or "wininet" for windows machine
#download.file(fileUrl, destfile = "./data/restaurants.csv", method = "curl")
download.file(fileUrl, destfile = "./data/restaurants.csv", method = "wininet")

restData <- read.csv("./data/restaurants.csv")

# look at a bit of the data 
head(restData, n = 3) # the top 3

tail(restData, n = 3) # the buttom 3

summary(restData)

str(restData)

quantile(restData$councilDistrict, na.rm = TRUE)
quantile(restData$councilDistrict, probs = c(0.5, 0.75, 0.9))
table(restData$zipCode, useNA = "ifany")
table(restData$councilDistrict, restData$zipCode)

# Check for missing values
sum(is.na(restData$councilDistrict))

any(is.na(restData$councilDistrict))

all(restData$zipCode > 0) # look if every sigle value satisfy the condition. 

colSums(is.na(restData)) # Sum NA value by column
all(colSums(is.na(restData)) ==0 )

table(restData$zipCode %in% c("21212")) # are there any zipcode equals "21212"

table(restData$zipCode %in% c("21212", "21213")) # all the zipcode equal "21212" or "21213"

restData[restData$zipCode %in% c("21212", "21213"),]

######## Chap3: Creating New Variables ########
# downlad and load the restaurant dataset as in the previous module

# create sequences // there are three way of creatins sequences
s1 <- seq(1, 10, by=2); s1
s2 <- seq(1, 10, length=3); s2
x <- c(1,3,8,25,100); seq(along = x)

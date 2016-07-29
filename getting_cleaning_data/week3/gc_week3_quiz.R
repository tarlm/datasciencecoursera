#################################################################################
# title: "gc_week3_quiz"
# author: "Rodrigue ADOUHOUEKONOU"
# descruption: "Script used to handle the quiz of getting and cleaning data module of week 3"
# date: "28 juillet 2016"
#################################################################################

require(dplyr)
require(jpeg) # install 'jpeg' package if needed

setwd("./getting_cleaning_data/week3/") # first set my working directory

# create data folder if not exist in order to store all ressources needed for the quiz
if(!file.exists("./data")){
    dir.create("./data")
}

##### Question 1: looking for the number of the households on greater than 10 acres ##### 
#### and Sales of Agriculture Products more than $10,000 (AGS=6)                     ####

# Download the 2006 microdata survey about housing for the state of Idaho 
# and load it in fss_df data frame
# method = "libcurl" or "wininet" for windows machine
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv"
download.file(fileUrl, destfile = "./data/dataFss06hid.csv", method = "wininet")

fss_df <- read.csv("./data/dataFss06hid.csv")
# look at a bit of the data 
head(fss_df, n = 3) # the top 3
tail(fss_df, n = 3) # the buttom 3
summary(fss_df)

#quantile(restData$councilDistrict, na.rm = TRUE)
#quantile(restData$councilDistrict, probs = c(0.5, 0.75, 0.9))

str(fss_df)
# Check for missing values of AGS and ACR
sum(is.na(fss_df$ACR))
sum(is.na(fss_df$AGS))

# look for the number of the households on greater than 10 acres (ACR=3) 
# and Sales of Agriculture Products more than $10,000 (AGS=6)
sum(fss_df$ACR ==3, na.rm = TRUE)
sum(fss_df$AGS ==6, na.rm = TRUE)

# Create the variable
agricultureLogical <- (fss_df$ACR==3 & fss_df$AGS ==6)
class(agricultureLogical)  # the result is [1] "logical"
# View the repartition  of TRUE and FALSE
table(fss_df$ACR==3 & fss_df$AGS ==6)

## The result is 125  238  262
which(agricultureLogical)


##### Question 2: Handle Jpeg file  ##### 

jpeg_url ="https://d396qusza40orc.cloudfront.net/getdata%2Fjeff.jpg"

jpeg_data <- jpeg(jpeg())





# Check for missing values

colSums(is.na(restData)) # Sum NA value by column
all(colSums(is.na(restData)) ==0 )

table(restData$zipCode %in% c("21212")) # are there any zipcode equals "21212"

table(restData$zipCode %in% c("21212", "21213")) # all the zipcode equal "21212" or "21213"

restData[restData$zipCode %in% c("21212", "21213"),]

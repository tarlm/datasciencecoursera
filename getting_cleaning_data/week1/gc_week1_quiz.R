# This script will need RCurl, packages
# install.packages("RCurl")
# install.packages("xlsx")
# install.packages("XML")
# require ti signal packages
require(RCurl)
require(xlsx)
require(XML)

setwd("d:\\DEV_SPACEs\\WorkSpaces\\RSpace\\datasciencecoursera\\Getting_Cleaning_Data\\week1")

# Load the package 

library(RCurl)



# Set the url object. 

url_csv <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv"

# download.file(url, destfile = "getDataFss.csv", method = "curl")
download.file(url_csv, destfile = "./getDataFss06hid.csv", method="libcurl")
list.files(".")

mydf <- read.csv("getDataFss06hid.csv", stringsAsFactors = FALSE)
head(mydf)

#Code book says VAL with 24 represents any house more than $1000000. 
#Following piece of code is trying to get count on house price >$1000000 whose value is not NA
length(mydf$VAL[!is.na(mydf$VAL) & mydf$VAL==24])



# Read excel file
url_xlsx <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FDATA.gov_NGAP.xlsx"

download.file(url=url_xlsx, destfile="gov_NGAP.xlsx", mode="w", method="libcurl")
library(xlsx)
rowIndex <- 18:23
colIndx <- 7:15

dat <- read.xlsx(file="gov_NGAP.xlsx",sheetIndex = 1, colIndex = colIndx, rowIndex = rowIndex, header=TRUE)

sum(dat$Zip*dat$Ext,na.rm=T)


## xml file 
library(XML)
url_xml <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Frestaurants.xml"
data <- xmlParse(file = url_xml)
rootNode <- xmlRoot(doc)
xmlName(rootNode)
zipcode <- xpathSApply(rootNode,"//zipcode",xmlValue)
length(zipcode[zipcode==21231])

#data_xml <- xmlToList(data)


## 5. 
url_csv5 <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06pid.csv"
download.file(url_csv5, destfile = "./getDataFss06pid.csv", method="libcurl")


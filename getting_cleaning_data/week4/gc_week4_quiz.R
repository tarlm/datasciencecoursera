#################################################################################
# title: "gc_week3_quiz"
# author: "Rodrigue ADOUHOUEKONOU"
# descruption: "Script used to handle the quiz of getting and cleaning data module of week 3"
# date: "28 juillet 2016"
#################################################################################

require(dplyr) # place older

setwd("./getting_cleaning_data/week4/") # first set my working directory

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

jpeg_url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fjeff.jpg"
file_path <- file.path(getwd(), "data/getdatajeff.jpg")
download.file(jpeg_url, file_path, mode = "wb" , method = "libcurl")

img_data <- readJPEG(file_path, native = TRUE)

## The result is -15259150 -10575416 
quantile(img_data, probs = c(0.3, 0.8))


##### Question 3: Handle CSVs file  ##### 

fgdp_url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv"
fgdp_path <- file.path(getwd(), "data/Fgdp.csv")
download.file(fgdp_url, fgdp_path, mode = "wb" , method = "libcurl")


fedStat_url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv"
fedStat_path <- file.path(getwd(), "data/fed_stats.csv")
download.file(fedStat_url, fedStat_path, mode = "wb" , method = "libcurl")

# load the csv files into data frame
fgdp_df <- fread(fgdp_path, skip = 5, header = FALSE, nrows = 190, select = c(1, 2, 4, 5), 
                 col.names = c("CountryCode", "Rank", "Economy", "Total"))

fedStat_df <- read.csv(fedStat_path)

# look at a bit of the data 
head(fgdp_df, n = 10)
head(fedStat_df, n = 10)
summary(fgdp_df)
summary(fedStat_df)
# Check for missing values
#colSums(is.na(fgdp_df)) # Sum NA value by column
# colSums(is.na(fedStat_df)) # Sum NA value by column

matched_table <- merge(fgdp_df, fedStat_df, by = 'CountryCode')

# number of matched rows ==> 189
NROW(matched_table)

# arrange by descend order of rank
matched_table <- matched_table %>% 
    arrange(desc(Rank))
# 13 th country is St. Kitts and Nevis
matched_table[13,]

##### Question 4: handle mean by Income.Group  ##### 
# High income: OECD = 32.96667, High income: nonOECD = 91.91304
tapply(matched_table$Rank, matched_table$Income.Group, mean)

quantile_grps <- quantile(matched_table$Rank, na.rm = TRUE)

##### Question 5: cut into five groups and group by Income.Group  ##### 

matched_table$RankGroups <- cut(matched_table$Rank, breaks = 5)

# the answer is 5
table(matched_table$RankGroups, matched_table$Income.Group)

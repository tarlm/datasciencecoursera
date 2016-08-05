#################################################################################
# title: "gc_week4_quiz"
# author: "Rodrigue ADOUHOUEKONOU"
# descruption: "Script used to handle the quiz of getting and cleaning data module of week 3"
# date: "28 juillet 2016"
#################################################################################

require(data.table)
require(dplyr)

setwd("./getting_cleaning_data/week4/") # first set my working directory

# create data folder if not exist in order to store all ressources needed for the quiz
if(!file.exists("./data")){
    dir.create("./data")
}


##### Question 1:  ##### 

fss_hid_file_url <- 
    "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv"
fss_hid_file_path <- file.path(getwd(), "data/data_fss_hid.csv") # set file_path on system
download.file(fss_hid_file_url, fss_hid_file_path, mode = "wb" , method = "libcurl")

fss_hid_df <- read.csv(fss_hid_file_path) 

View(fss_hid_df)
# split data frame names on "wgtp". Then the 123th element 
    #==> The result is [1] ""   "15"
strsplit(names(fss_hid_df), "wgtp")[123]

##### Question 2:  ##### 

fgdp_file_url <- 
    "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv" # set the remote csv url

fgdp_csv_file_path <- file.path(getwd(), "data/data_FGDP.csv") # set file_path on system

download.file(fgdp_file_url, fgdp_csv_file_path, mode = "wb" , method = "libcurl")

# load the csv in order to explore the file structure
fgdp_df <- read.csv(fgdp_csv_file_path, header = FALSE) 
# explore data
View(fgdp_df)

# load the csv files into data table with corrects filters
fgdp_df <- fread(fgdp_csv_file_path, skip = 5, header = FALSE, nrows = 190, select = c(1, 2, 4, 5), 
                 col.names = c("CountryCode", "ranking", "countryNames", "GDP"))

View(fgdp_df)

fgdp_df <- mutate(fgdp_df, GDP = as.numeric(gsub(",", "", fgdp_df$GDP)))

#my_gdp <- as.numeric(gsub(",", "", fgdp_df$GDP))

#the resultat is [1] 377652.4
mean(fgdp_df$GDP)

##### Question 3:  ##### 

grep("^United",fgdp_df$countryNames)

#the result is grep("^United",countryNames), 3

##### Question 4:  ##### 

# Load the educational data from this data set:
fedu_file_url <- 
    "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv"

fedu_csv_file_path <- file.path(getwd(), "data/data_fedu.csv") # set file_path on system

download.file(fedu_file_url, fedu_csv_file_path, mode = "wb" , method = "libcurl")

fedu_df <- read.csv(fedu_csv_file_path, header = TRUE) 

View(fedu_df)

fedu_df_tb <- tbl_df(fedu_df)

matched_table <- merge(fgdp_df, fedStat_df, by = 'CountryCode')














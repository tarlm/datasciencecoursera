#################################################################################
# title: "gc_week4_quiz"
# author: "Rodrigue ADOUHOUEKONOU"
# descruption: "Script used to handle the quiz of getting and cleaning data module of week 3"
# date: "28 juillet 2016"
#################################################################################

require(data.table)
require(quantmod)

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
fgdp_df <- data.table(read.csv(fgdp_csv_file_path, skip = 4, nrows = 190,
                               stringsAsFactors = FALSE))
# View data
View(fgdp_df)

fgdp_df <- fgdp_df[, list(X, X.1, X.3, X.4)]

setnames(fgdp_df, c("X", "X.1", "X.3", "X.4"), 
         c("CountryCode", "ranking", "countryNames", "GDP"))

View(fgdp_df)

#fgdp_df <- mutate(fgdp_df, GDP = as.numeric(gsub(",", "", fgdp_df$GDP)))

gdp <- as.numeric(gsub(",", "", fgdp_df$GDP))

#the resultat is [1] 377652.4
mean(gdp, na.rm = TRUE)

##### Question 3:  ##### 

united <- grepl("United",fgdp_df$countryNames)
summary(united)

#the result is grep("^United",countryNames), 3


##### Question 4:  ##### 

# Load the educational data from this data set:
fedStat_file_url <- 
    "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv"

fedStat_csv_file_path <- file.path(getwd(), "data/data_fedStat.csv") # set file_path on system

download.file(fedStat_file_url, fedStat_csv_file_path, mode = "wb" , method = "libcurl")

fedStat_df <- data.table(read.csv(fedStat_csv_file_path, header = TRUE))

View(fedStat_df)

#fedStat_df_tb <- tbl_df(fedStat_df)
names(fedStat_df)

matched_table <- merge(fgdp_df, fedStat_df, all = TRUE, by = 'CountryCode')

isFiscalYearEnd <- grepl("fiscal year end", tolower(matched_table$Special.Notes))

isJune <- grepl("june", tolower(matched_table$Special.Notes))

table(isFiscalYearEnd, isJune)
# the result is 13
matched_table[isFiscalYearEnd & isJune, Special.Notes]

##### Question 5:  ##### 

amzn <- getSymbols("AMZN", auto.assign=FALSE)
sampleTimes <- index(amzn)

View(amzn)

# The result is 2012    51    47    50       51       51  250
addmargins(table(year(sampleTimes), weekdays(sampleTimes)))

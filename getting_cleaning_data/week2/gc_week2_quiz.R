#################################################################################
# title: "Getting and cleaning data Week 2 Quiz"
# author: "Rodrigue ADOUHOUEKONOU"
# descruption: "Script used to handle the week 2 quiz of getting and cleaning data module"
# date: "21 juillet 2016"
#################################################################################

# To handle the assignment for quiz of week 2
require(httr)
require(httpuv)
require(jsonlite)

setwd("d:\\DEV_SPACEs\\WorkSpaces\\RSpace\\datasciencecoursera\\Getting_Cleaning_Data\\week2")

######## Question 1 ######

# 1. Find OAuth settings for github:
#    http://developer.github.com/v3/oauth/
oauth_endpoints("github")

# 2. To make your own application, register at at
#    https://github.com/settings/applications. Use any URL for the homepage URL
#    (http://github.com is fine) and  http://localhost:1410 as the callback url
#
#    Replace your key and secret below.
# original conf myapp <- oauth_app("github", key = "56b637a5baffac62cad9",
#                   secret = "8e107541ae1791259e9987d544ca568633da2ebf")

myapp <- oauth_app("github", key = "fd4da595c50a62047f68",
                   secret = "27579932645ba93296da5840e3aefe2b6381385d")


# 3. Get OAuth credentials
github_token <- oauth2.0_token(oauth_endpoints("github"), myapp)

# 4. Use API
gtoken <- config(token = github_token)
# original call req <- GET("https://api.github.com/rate_limit", gtoken)

req <- GET("https://api.github.com/users/jtleek/repos", gtoken)
    
stop_for_status(req)
class(req)
repo_list <- content(req)
class(repo_list)

for(i in 1:length(repo_list)){
    if(repo_list[[i]]$name =="datasharing"){
        founded_repo <- repo_list[[i]]
        break()
    }
}

# creation date of the sharing repo
if (length(founded_repo) == 0) {
    msg("No such repository found: 'datasharing'")
} else {
    msg("The repository 'datasharing' was created at", founded_repo$created_at)
}

######## Question 2 ######
require(sqldf)

url_csv <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06pid.csv"
download.file(url_csv, destfile = "./getDataFss06hid.csv", method="libcurl")
list.files(".")
# Load in acs R object
acs <- read.csv("getDataFss06hid.csv", stringsAsFactors = FALSE)
head(acs)
sqldf("select pwgtp1 from acs where AGEP < 50")

######## Question 3 ######

sqldf("select distinct AGEP from acs")

######## Question 4 ######
require(XML)

page_url <- "http://biostat.jhsph.edu/~jleek/contact.html"
con <- url(page_url)
page_content_html <- readLines(con = con)
close(con = con)
class(page_content_html)

line_numbers <- c(10, 20, 30, 100)
    
lines_nchar <- c()

sapply(line_numbers, function(line_number){
    lines_nchar <<- c(lines_nchar, nchar(page_content_html[line_number]))
})

lines_nchar

######## Question 5 ######

url_raw_file <- "https://d396qusza40orc.cloudfront.net/getdata%2Fwksst8110.for"
raw_file_name <- "getDataFwk8110.for"
download.file(url_raw_file, destfile = raw_file_name , method="libcurl")
list.files(".")
col_seq <- c(-5, 4, 4)
widths <- c(-1, 9, col_seq, col_seq, col_seq, col_seq)

raw_df <- read.fwf(raw_file_name, widths = widths, skip = 4)
result <- sum(raw_df[, 4])
result


    
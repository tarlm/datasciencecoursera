#################################################################################
# title: "week2_handler"
# author: "Rodrigue ADOUHOUEKONOU"
# descruption: "Script used to handle getting and cleaning data module of week 2"
# date: "21 juillet 2016"
#################################################################################
require(RMySQL)
########  R Reading from MySQL
#
# The URL of the web site of genome database to use is: <http://genome.ucsc.edu/>  
# And the open database page is: <http://genome.ucsc.edu/goldenPath/help/mysql.html>

# Connecting and listing databases 
ucscDb <- dbConnect(MySQL(), user = "genome", host = "genome-mysql.cse.ucsc.edu")
result <- dbGetQuery(conn = ucscDb, statement = "show databases;")

# disconnect from db. Very important to always disconnect from the db.
dbDisconnect(conn = ucscDb)

# Connecting to db hg19 and listing tables 
hg19 <- dbConnect(MySQL(), user = "genome", 
                  host = "genome-mysql.cse.ucsc.edu", db="hg19")

allTables <- dbListTables(conn = hg19)
length(allTables)
allTables[1:5]
#list fields of specific table "affyU133Plus2"
dbListFields(conn = hg19, "affyU133Plus2")
dbGetQuery(conn = hg19, statement = "select count(*) from affyU133Plus2;")
# Read a table
affyData <- dbReadTable(conn = hg19, name = "affyU133Plus2")
head(affyData)

# Select a specific subset 
query <- dbSendQuery(conn = hg19, statement = 
                         "SELECT * FROM affyU133Plus2 WHERE misMatches between 1 and 3 ")

affyMis <- fetch(query)

quantile(affyMis$misMatches)

affyMisSmall <- fetch(query, n = 10)
dbClearResult(query)

dim(affyMisSmall)
# disconnect
dbDisconnect(conn = hg19)

########  ########

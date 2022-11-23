# About this script -------------------------------------------------------
# Author: Christopher Maronga
# Purpose: Demonstration codes for the workshop
# Date created: 14/10/2022

# load packages
library(DBI)        # Main database interface for R
library(dbplyr)     # Handles dplyr translation to SQL
library(tidyverse)  # tidyverse world of package (including dplyr, ggplot2, etc.)
library(RSQLite)    # DBI back-end package for connecting to SQLite
library(odbc)       # DBI back-end  to connect to most RDBMS & SQL server
library(RMySQL)     # DBI back-end package for connecting to MySQL
library(redcapAPI)  # Connecting to REDCap database


# Session 1 demo ----------------------------------------------------------
# We will use the `nhsr_conference` database

## Creating a connection using odbc driver ----

# list available odbc drivers for your system/computer
sort(unique(odbcListDrivers()[[1]])) # If you can't find any drivers, you can install them


# using MySQL driver
my_db.con <- dbConnect(odbc(),                                       
                           Driver = "MySQL ODBC 8.0 Unicode Driver", # might be different with yours, kindly check  
                           Server = "nhsr-conference.cjmn9gy7nffs.us-east-1.rds.amazonaws.com",   
                           Database = "nhsr_conference",               
                           Uid = "user",                          
                           Pwd = "user" )

# using MySQL backend package RMySQL
my_db.conOpt2 <- dbConnect(MySQL(),  
                          host = "nhsr-conference.cjmn9gy7nffs.us-east-1.rds.amazonaws.com",    
                          dbname = "nhsr_conference",   
                          user = "user",    
                          password = "user") 



## Explore the connections using class


# List tables in the database(s)
dbListTables(conn = my_db.con)



# List fields/variables in a specific table in a database
# e.g.
dbListFields(conn = my_db.conOpt2, name = "tbl_clinical")



## Querying data from a database using a connection ------

# (1) dbSendQuery() and dbFetch()

# execute query
results <- dbSendQuery(conn = my_db.conOpt2, statement = "SELECT * FROM tbl_lab")

# Fetch results (dbFetch)
lab_data <- dbFetch(res = results)


# (2)dbGetQuery()
lab_dataOpt2 <- dbGetQuery(conn = my_db.conOpt2,
                           statement = "SELECT * FROM tbl_lab")


# (3) Using dplyr syntax

baseline <- tbl(my_db.con, "tbl_baseline")

# check class of baseline
class(baseline)

nrow(baseline) # NOTEfails to return any value
dim(baseline)  # Can't tell you for sure how many rows

# Why is this? because `baseline` is just a connection and not the actual data

# Get data into memory using collect()

baseline_df <- baseline %>% collect()

nrow(baseline_df)


# Let's try a complex example
severe_pal.fever <- tbl(my_db.conOpt2, "tbl_clinical") %>% 
  filter(pallor == "Severe", fever == 1) %>% 
  collect()


# You can show the SQL query
tbl(my_db.conOpt2, "tbl_clinical") %>% 
  filter(pallor == "Severe", fever == 1) %>% 
  show_query()



# Session 2 demo ----------------------------------------------------------

# create a connection
my_redcap_con <- redcapConnection(url = "https://uat.chainnetwork.org/redcap/api/",
                                    token = "125AAA97191E444C80E5A796C40F1E52")         




## Explore the connection -----

# events
exportEvents(my_redcap_con)

# instruments/forms/questionnaires
exportInstruments(my_redcap_con)

# metadata/more like a data dictionary for all variables
meta_data <- exportMetaData(my_redcap_con)

#Export arms
exportArms(my_redcap_con)



## Export data (wholesome)
redcap_data <- exportRecords(rcon = my_redcap_con)



## Export baseline data
baseline_raw <- exportRecords(
  rcon = my_redcap_con,
  factors = TRUE,
  fields = NULL,
  forms = NULL,
  records = NULL,
  events = "baseline_arm_1",
  labels = TRUE,
  dates = TRUE,
  survey = TRUE,
  dag = TRUE,
  checkboxLabels = FALSE
)


## export baseline and study exit data

baseline_stExit <- exportRecords(
  rcon = my_redcap_con,
  factors = TRUE,
  fields = NULL,
  forms = NULL,
  records = NULL,
  events = c("baseline_arm_1","study_end_arm_1"),
  labels = TRUE,
  dates = TRUE,
  survey = TRUE,
  dag = TRUE,
  checkboxLabels = FALSE
)


# NOTE: If you want a wide_format data, export separately and combine (Recommended)
# You will try this in the exercise


# Session 3 demo ----------------------------------------------------------

file.edit("~/.Renviron")










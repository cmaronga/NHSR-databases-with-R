# Title: Exercise 2 - Querying data from MySQL database
# Author: Christopher Maronga
# Date: 01/11/2022


# load required packages --------------------------------------------------

library(DBI)        # Main database interface for R
library(dbplyr)     # Handles dplyr translation to SQL
library(tidyverse)  # tidyverse world of package (including dplyr, ggplot2, etc.)
library(RSQLite)    # DBI back-end package for connecting to SQLite
library(odbc)       # DBI back-end  to connect to most RDBMS & SQL server
library(RMySQL)     # DBI back-end package for connecting to MySQL
library(redcapAPI)  # Connecting to REDCap database


# Task : Establish a connection to `nhsr_conference` database and use it to
# Use any method to connect to the database
# complete the below tasks.

## ------------- A
# (a) Use DBI functions dbSendQuery() and dbFetch()

# (i). Excute a SQL query selecting all fields of the `tbl_clinical` table


# (ii). Fetch the results of the query above and assign them to `clinical_opt1`


# (b) use dbGetQuery() to execute the SQL above (i) and assign to `clinical_opt2`
## NOTE: this is equivalent to using the function dbReadTable()


## --- At your own time, repeat the above exercise by selecting ONLY subjid, temp, fever for patients
  ## from site 2: Hint: You will need to do a join to achieve this



## ------------- B

# use the tbl() function and collect() to complete the set of exercise below

# (i) Extract the lab data (`tbl_lab`) and assign it to `lab_data` in your enviroment


# (ii) Extract from `tbl_baseline` patients whose sex == 1 and site == 3, assign to `site1_male.df`


# (iii) Use an appropriate join to extract and combine all tables of the database, assign to `study_raw`


### --- Feel free to play around with the connections and the databases as you wish just to get comfortable and 
# familiar with the concepts.











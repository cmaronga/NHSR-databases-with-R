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



# using MySQL driver





# using MySQL backend package RMySQL





## Explore the connections using class


# List tables in the database(s)




# List fields/variables in a specific table in a database
# e.g.




## Querying data from a database using a connection ------

# (1) dbSendQuery() and dbFetch()

# execute query


# Fetch results (dbFetch)



# (2)dbGetQuery()



# (3) Using dplyr syntax



# check class of object




# Get data into memory using collect()




# Let's try a complex example




# You can show the SQL query


# Session 2 demo ----------------------------------------------------------

# create a connection
my_redcap_con <- redcapConnection(url = "https://uat.chainnetwork.org/redcap/api/",
                                  token = "125AAA97191E444C80E5A796C40F1E52")         




## Explore the connection -----

# events


# instruments/forms/questionnaires


# metadata/more like a data dictionary for all variables


#Export arms




## Export data (wholesome)




## Export baseline data



## export baseline and study exit data




# NOTE: If you want a wide_format data, export separately and combine (Recommended)
# You will try this in the exercise

# Session 3 demo ----------------------------------------------------------




































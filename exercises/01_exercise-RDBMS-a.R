# Title: Exercise 1 - Connecting to MySQL database
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

# Introduction.
# - The aim of this exercise is to get you started with connecting R to your
# -  RDBMS (MySQL, SQL server) or any vendor for the same.




# Task : Connect to `nycflights13` MySQL database;

# (i) Use an `odbc` driver, name the connection `nyc_odbc.conn`
# Hint: 
sort(unique(odbcListDrivers()[[1]])) # Run this to see available odbc drivers





# (ii) Use a `DBI` backend package for MySQL, name the connection `nyc_dbi.conn`





# (iii) Explore the connections

# How many tables are in the connection `nyc_odbc.conn`?

# How many tables are in the connection `nyc_dbi.conn`?


## Using either of the database connections above, how many variables are in table airports table?(tbl_airports)
















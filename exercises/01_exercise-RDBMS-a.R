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

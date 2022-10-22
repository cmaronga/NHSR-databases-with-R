# About this script -------------------------------------------------------
# Author: Christopher Maronga
# Purpose: Preparation of RDBMS for NHSR-Conference 2022
# Date created: 14/10/2022

# Loading packages --------------------------------------------------------
library(DBI)  # R database interface
library(odbc)  # connection to odbc compatible database
library(RSQLite) # Backed driver for SQLite
library(RMySQL) # Backed driver for MySQL
library(tidyverse) # dplyr verbs and more
library(redcapAPI) # connecting to REDCap database
library(nycflights13)
library(here)

# load datasets for nhsr_conference BD
baseline_data <- read_csv(here("datasets", "baseline_data.csv"))
clinical_data <- read_csv(here("datasets", "clinical_data.csv"))
lab_results <- read_csv(here("datasets", "lab_results.csv"))

# Creating nycflights13 DB ------------------------------------------------

# world
nycy_con <- dbConnect(MySQL(),
                       host = Sys.getenv("host_name"),
                       dbname = "nycflights13",
                       user = Sys.getenv("admin_user"),
                       #port = 3306,
                       password = Sys.getenv("admin_pwd"))


# export tables
# nycflights13::airlines
dbWriteTable(nycy_con, 
             name = "tbl_airlines", 
             value = nycflights13::airlines,
             overwrite = T,
             row.names = F)




# nycflights13::airports
dbWriteTable(nycy_con, 
             name = "tbl_airports", 
             value = nycflights13::airports,
             overwrite = T,
             row.names = F)

# nycflights13::flights
dbWriteTable(nycy_con, 
             name = "tbl_flights", 
             value = nycflights13::flights,
             overwrite = T,
             row.names = F)


# nycflights13::planes
dbWriteTable(nycy_con, 
             name = "tbl_planes", 
             value = nycflights13::planes,
             overwrite = T,
             row.names = F)


# nycflights13::weather
dbWriteTable(nycy_con, 
             name = "tbl_weather", 
             value = nycflights13::weather,
             overwrite = T,
             row.names = F)

dbListTables(nycy_con)

# creating the nhsr_conference BD -----------------------------------------

nhs_r.con <- dbConnect(MySQL(),
                      host = Sys.getenv("host_name"),
                      dbname = "nhsr_conference",
                      user = Sys.getenv("admin_user"),
                      password = Sys.getenv("admin_pwd"))


# baseline data
dbWriteTable(conn = nhs_r.con, 
             name = "tbl_baseline",
             value = baseline_data,
             overwrite = T,
             row.names = F)

# clinical file
dbWriteTable(conn = nhs_r.con, 
             name = "tbl_clinical",
             value = clinical_data,
             overwrite = T,
             row.names = F)


# lab results
# add additional variables to lab results
set.seed(20221005)
lab_results <- lab_results %>% 
  mutate(
    hb = runif(226, min = 9.5, max = 24.5),
    creatinine = runif(226, min = 0.42, max = 0.48)
  )


dbWriteTable(conn = nhs_r.con, 
             name = "tbl_lab",
             value = lab_results,
             overwrite = T,
             row.names = F)


dbListTables(nhs_r.con)









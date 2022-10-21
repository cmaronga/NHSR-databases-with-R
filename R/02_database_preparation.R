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
                       host = "nhsr-conference.cjmn9gy7nffs.us-east-1.rds.amazonaws.com",
                       dbname = "nycflights13",
                       user = "admin",
                       #port = 3306,
                       password = "nhsr_2022")

dbListTables(nycy_con)

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



nycy_con.ser <- dbConnect(MySQL(),
                      host = "nhsr-conference.cjmn9gy7nffs.us-east-1.rds.amazonaws.com",
                      dbname = "nycflights13",
                      user = "user",
                      password = "user")


# list tables
dbListTables(nycy_con.ser)

dbListFields(nycy_con.ser, name = "tbl_airlines")


# creating the nhsr_conference BD -----------------------------------------

nhs_r.con <- dbConnect(MySQL(),
                      host = "nhsr-conference.cjmn9gy7nffs.us-east-1.rds.amazonaws.com",
                      dbname = "nhsr_conference",
                      user = "admin",
                      password = "nhsr_2022")


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












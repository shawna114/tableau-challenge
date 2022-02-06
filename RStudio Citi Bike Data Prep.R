library(tidyverse)
library(dplyr)
library(data.table)



Jan2019 <- data.table::fread("201901-citibike-tripdata.csv")%>% add_column(Month_Year='Jan-2019')
Feb2019 <- data.table::fread("201902-citibike-tripdata.csv")%>% add_column(Month_Year='Feb-2019')
Mar2019 <- data.table::fread("201903-citibike-tripdata.csv")%>% add_column(Month_Year='Mar-2019')
Apr2019 <- data.table::fread("201904-citibike-tripdata.csv")%>% add_column(Month_Year='Apr-2019')
May2019 <- data.table::fread("201905-citibike-tripdata.csv")%>% add_column(Month_Year='May-2019')
Jun2019 <- data.table::fread("201906-citibike-tripdata.csv")%>% add_column(Month_Year='Jun-2019')
Jul2019 <- data.table::fread("201907-citibike-tripdata.csv")%>% add_column(Month_Year='Jul-2019')
Aug2019 <- data.table::fread("201908-citibike-tripdata.csv")%>% add_column(Month_Year='Aug-2019')
Sep2019 <- data.table::fread("201909-citibike-tripdata.csv")%>% add_column(Month_Year='Sep-2019')
Oct2019 <- data.table::fread("201910-citibike-tripdata.csv")%>% add_column(Month_Year='Oct-2019')
Nov2019 <- data.table::fread("201911-citibike-tripdata.csv")%>% add_column(Month_Year='Nov-2019')
Dec2019 <- data.table::fread("201912-citibike-tripdata.csv")%>% add_column(Month_Year='Dec-2019')
Jan2020 <- data.table::fread("202001-citibike-tripdata.csv")%>% add_column(Month_Year='Jan-2020')
Feb2020 <- data.table::fread("202002-citibike-tripdata.csv")%>% add_column(Month_Year='Feb-2020')
Mar2020 <- data.table::fread("202003-citibike-tripdata.csv")%>% add_column(Month_Year='Mar-2020')
Apr2020 <- data.table::fread("202004-citibike-tripdata.csv")%>% add_column(Month_Year='Apr-2020')
May2020 <- data.table::fread("202005-citibike-tripdata.csv")%>% add_column(Month_Year='May-2020')
Jun2020 <- data.table::fread("202006-citibike-tripdata.csv")%>% add_column(Month_Year='Jun-2020')
Jul2020 <- data.table::fread("202007-citibike-tripdata.csv")%>% add_column(Month_Year='Jul-2020')
Aug2020 <- data.table::fread("202008-citibike-tripdata.csv")%>% add_column(Month_Year='Aug-2020')
Sep2020 <- data.table::fread("202009-citibike-tripdata.csv")%>% add_column(Month_Year='Sep-2020')
Oct2020 <- data.table::fread("202010-citibike-tripdata.csv")%>% add_column(Month_Year='Oct-2020')
Nov2020 <- data.table::fread("202011-citibike-tripdata.csv")%>% add_column(Month_Year='Nov-2020')
Dec2020 <- data.table::fread("202012-citibike-tripdata.csv")%>% add_column(Month_Year='Dec-2020')


#Bind tables together
citi_start_data <- rbind.data.frame(Jan2019, Feb2019,	Mar2019,	Apr2019,	May2019,	Jun2019,	Jul2019,	Aug2019,	Sep2019,	Oct2019,	Nov2019,	Dec2019, Jan2020, Feb2020,	Mar2020,	Apr2020,	May2020,	Jun2020,	Jul2020,	Aug2020,	Sep2020,	Oct2020,	Nov2020,	Dec2020)

#Select columns to keep, group data and create calculations for start stations
citi_start_1 <- citi_start_data %>% select('tripduration','starttime','stoptime','start station name','start station latitude','start station longitude','end station name','end station latitude','end station longitude','birth year','Month_Year','gender')
citi_start_2 <- citi_start_1 %>% group_by(Month_Year,`start station name`)
citi_start_3 <- citi_start_2 %>% summarise(avg.trip.duration=mean(tripduration), totaltrips=n(), station.lat=mean(`start station latitude`), station.lng=mean(`start station longitude`), sum.age=sum(as.integer(substring(starttime,1,4))-`birth year`), station_type='Start Station')                                                                                                                                                     
citi_start_4 <- citi_start_3 %>% rename('station' = 'start station name')

#Select columns to keep, group data and create calculations for ending stations
citi_end_1 <- citi_start_1 %>% group_by(Month_Year,`end station name`)
citi_end_2 <- citi_end_1 %>% summarise(avg.trip.duration=mean(tripduration), totaltrips=n(), station.lat=mean(`end station latitude`), station.lng=mean(`end station longitude`), sum.age=sum(as.integer(substring(starttime,1,4))-`birth year`), station_type='End Station')                                                                                                                                                      
citi_end_3 <- citi_end_2 %>% rename('station' = 'end station name')

#Append citi_start and citi_end data into one table
combined_start_end <- rbind.data.frame(citi_start_4, citi_end_3)
write.csv(combined_start_end, "C://Users/shawn/citi_combined.csv")

#Select columns to keep, group data and create calculations for start stations to show busy days of week
citi_start_busy <- citi_start_1 %>% group_by(Month_Year, `start station name`, weekdays(starttime)) 
citi_start_busy1 <- citi_start_busy %>% summarise(totaltrips=n(), station_type='Start Station')
citi_start_busy2 <- citi_start_busy1 %>% rename('station' = `start station name`, 'weekdays' = `weekdays(starttime)`)

#Select columns to keep, group data and create calculations for end stations to show busy days of week
citi_end_busy <- citi_start_1 %>% group_by(Month_Year, `end station name`, weekdays(stoptime)) 
citi_end_busy1 <- citi_end_busy %>% summarise(totaltrips=n(), station_type='End Station')
citi_end_busy2 <- citi_end_busy1 %>% rename('station' = 'end station name', 'weekdays' = `weekdays(stoptime)`)

#Append busy_start and busy_end data into one table
combined_busy <- rbind.data.frame(citi_start_busy2, citi_end_busy2)
write.csv(combined_busy, "C://Users/shawn/citi_busy_combined.csv")

#Select columns to keep, group data and create calculations for start stations to show busy hours of day
citi_start_time <- citi_start_1 %>% group_by(Month_Year, `start station name`, format(as.POSIXct(starttime), format = "%H"))
citi_start_time1 <- citi_start_time %>% summarise(totaltrips=n(), station_type = 'Start Station')
citi_start_time2 <- citi_start_time1 %>% rename('station' = 'start station name', 'hour' = `format(as.POSIXct(starttime), format = "%H")`)

#Select columns to keep, group data and create calculations for end stations to show busy hours of day
citi_stop_time <- citi_start_1 %>% group_by(Month_Year, `end station name`, format(as.POSIXct(stoptime), format = "%H"))
citi_stop_time1 <- citi_stop_time %>% summarise(totaltrips=n(), station_type = 'End Station')
citi_stop_time2 <- citi_stop_time1 %>% rename('station' = 'end station name', 'hour' = 'format(as.POSIXct(stoptime), format = "%H")')

#Append time_start and time_end data into one table
combined_time <- rbind.data.frame(citi_start_time2, citi_stop_time2)
write.csv(combined_time, "C://Users/shawn/citi_time_combined.csv")

#Select columns to keep, group data and create calculations for start stations to show gender data
citi_start_gender <- citi_start_1 %>% group_by(Month_Year, `start station name`, gender)
citi_start_gender1 <- citi_start_gender %>% summarise(totaltrips=n(), station_type = 'Start Station')
citi_start_gender2 <- citi_start_gender1 %>% rename('station' = 'start station name')
citi_start_gender2

#Select columns to keep, group data and create calculations for end stations to show gender data
citi_stop_gender <- citi_start_1 %>% group_by(Month_Year, `end station name`, gender)
citi_stop_gender1 <- citi_stop_gender %>% summarise(totaltrips=n(), station_type = 'End Station')
citi_stop_gender2 <- citi_stop_gender1 %>% rename('station' = 'end station name')
citi_stop_gender2

#Append gender_start and gender_end data into one table
combined_gender <- rbind.data.frame(citi_start_gender2, citi_stop_gender2)
write.csv(combined_gender, "C://Users/shawn/citi_gender_combined.csv")





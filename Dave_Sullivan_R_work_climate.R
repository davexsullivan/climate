install.packages('weathercan')
install.packages('sp')
install.packages('ggplot2')
install.packages("dplyr")
install.packages("corrplot")
install.packages("ggpubr")

library(weathercan)
library(ggplot2)
library(sp)
library(dplyr)
library(corrplot)
library(ggpubr)

#Checking to ensure 64-bit version of R in use, to prevent memory errors
sessionInfo() 

#getting data from 150km radius of Toronto
toronto_100_day_list<-  stations_search(coords=c(43.6,-79.3), dist=150, interval='day', starts_latest=1984, ends_earliest = 2017)
toronto_100_month_list<-  stations_search(coords=c(43.6,-79.3), dist=150, interval='month', starts_latest=1984, ends_earliest = 2017)

toronto_100_day_data<-weather_dl(station_ids= c(toronto_100_day_list$station_id), start='1980-01-01', interval='day', string_as = NULL, verbose=TRUE)
toronto_100_month_data<-weather_dl(station_ids= c(toronto_100_month_list$station_id), start='1980-01-01', interval='month', string_as = NULL, verbose=TRUE)

write.csv(toronto_100_day_data, "C:/data_analytics/climate/toronto_100_day_data.csv")
write.csv(toronto_100_month_data, "C:/data_analytics/climate/toronto_100_month_data.csv")

#Getting all stations data with appropriate date range
all_stations_day_list<-filter(stations,  stations$start<=1950, stations$end>=2018, interval=='day' )
all_stations_month_list<-filter(stations,  stations$start<=1980, stations$end>=2018, interval=='month' )

all_stations_day_data<-weather_dl(station_ids= c(all_stations_day_list$station_id), start='1980-01-01', interval='day', string_as = NULL, verbose=TRUE)
all_stations_month_data<-weather_dl(station_ids= c(all_stations_month_list$station_id), start='1980-01-01', interval='month', string_as = NULL, verbose=TRUE)

write.csv(all_stations_day_data, "C:/data_analytics/climate/all_stations_day_data.csv")
write.csv(all_stations_month_data, "C:/data_analytics/climate/all_stations_month_data.csv")



all_stations_final <- read.csv("C:/data_analytics/climate/all_stations_final.csv", header = TRUE, sep = ",")
toronto_stations_final <- read.csv("C:/data_analytics/climate/toronto_stations_final.csv", header = TRUE, sep = ",")
toronto<-toronto_stations_final[,]

ggscatter(my_data, x = "mpg", y = "wt", 
          add = "reg.line", conf.int = TRUE, 
          cor.coef = TRUE, cor.method = "pearson",
          xlab = "Miles/(US) gallon", ylab = "Weight (1000 lbs)")
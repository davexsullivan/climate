install.packages('weathercan')
install.packages('sp')
install.packages('ggplot2')
install.packages("dplyr")
install.packages("corrplot")
install.packages("ggpubr")
install.packages("readxl")


library(weathercan)
library(ggplot2)
library(sp)
library(dplyr)
library(corrplot)
library(ggpubr)
library(readxl)

#Checking to ensure 64-bit version of R in use, to prevent memory errors
sessionInfo() 

#getting data from 150km radius of Toronto
attach(stations)

toronto_200_day_list<-  stations_search(coords=c(43.6,-79.3), dist=200, 
                                        interval='day', starts_latest=1980, ends_earliest = 2017)
toronto_200_data<-weather_dl(station_ids= c(toronto_200_day_list$station_id), start='1980-01-01', 
                             interval='day', string_as = NULL, verbose=TRUE)
write.csv(toronto_200_data, "C:/GIT/climate/data/toronto_200_data.csv")

vancouver_200_day_list<-  stations_search(coords=c(49.4,-123.1), dist=200, interval='day',
    starts_latest=1980, ends_earliest = 2017)
vancouver_200_data<-weather_dl(station_ids= c(vancouver_200_day_list$station_id), 
                               start='1980-01-01', interval='day', string_as = NULL, verbose=TRUE)
write.csv(vancouver_200_data, "C:/GIT/climate/data/vancouver_200_data.csv")


#Getting all stations data with appropriate date range
all_stations_day_list<-filter(stations,  start<=1975, end>=2019, interval=='day' )
all_stations_month_list<-filter(stations,  start<=1980, end>=2016, interval=='month' )

#Attempting to download all at once caused crashes (~4mil rows)
#Split into equal smaller groups
quantile(all_stations_day_list$station_id)

all_stations_day_list1<-filter(stations, station_id<1181,  start<=1975, end>=2019, interval=='day' )
all_stations_day_list2<-filter(stations, station_id>=1181, station_id<3888,
                               start<=1975, end>=2019, interval=='day' )
all_stations_day_list3<-filter(stations, station_id>=3888, station_id<5423,
                               start<=1975, end>=2019, interval=='day' )
all_stations_day_list4<-filter(stations, station_id>=5423, start<=1975, end>=2019, interval=='day' )

all_stations_day_data1<-weather_dl(station_ids= c(all_stations_day_list1$station_id), 
                                   start='1980-01-01', interval='day', string_as = NULL, verbose=TRUE)
all_stations_day_data2<-weather_dl(station_ids= c(all_stations_day_list2$station_id), 
                                   start='1980-01-01', interval='day', string_as = NULL, verbose=TRUE)
all_stations_day_data3<-weather_dl(station_ids= c(all_stations_day_list3$station_id), 
                                   start='1980-01-01', interval='day', string_as = NULL, verbose=TRUE)
all_stations_day_data4<-weather_dl(station_ids= c(all_stations_day_list4$station_id), 
                                   start='1980-01-01', interval='day', string_as = NULL, verbose=TRUE)

all_stations_data<-rbind(all_stations_day_data1,all_stations_day_data2,all_stations_day_data3,all_stations_day_data4)
write.csv(all_stations_data, "C:/GIT/climate/data/all_stations_data.csv")

#Create unique list of stations for use as an index
list_all_stations<-rbind(toronto_200_day_list[,c(1,2,3,4,5,6,7,8,9,10,11,12,13,14)],
      vancouver_200_day_list[,c(1,2,3,4,5,6,7,8,9,10,11,12,13,14)],all_stations_day_list )
which(duplicated(list_all_stations$station_id))
list_all_stations<-list_all_stations[!duplicated(list_all_stations$station_id), ]
write.csv(list_all_stations, "C:/GIT/climate/data/station_index.csv")

#Export data to SQL for cleaning and aggregation
#This is where climate_sql_work.sql  is run

#Import the finalized data from sql:


#Importing all the aggregated data
all_stations_annual <- read.csv("C:/GIT/climate/data/all_stations_annual.csv", header = TRUE, sep = ",")
all_stations_summer <- read.csv("C:/GIT/climate/data/all_stations_summer.csv", header = TRUE, sep = ",")
toronto_daily <- read.csv("C:/GIT/climate/data/toronto_daily.csv", header = TRUE, sep = ",")
toronto_annual <- read.csv("C:/GIT/climate/data/toronto_annual.csv", header = TRUE, sep = ",")
toronto_summer <- read.csv("C:/GIT/climate/data/toronto_summer.csv", header = TRUE, sep = ",")
vancouver_annual <- read.csv("C:/GIT/climate/data/vancouver_annual.csv", header = TRUE, sep = ",")
vancouver_summer <- read.csv("C:/GIT/climate/data/vancouver_summer.csv", header = TRUE, sep = ",")


#Selecting the larger latitude groups by population, keeping only the measures
all_47to49 <- subset(all_stations_annual,lat_range=='47to49',c(3,4,5,6,7,8,9))
all_49to51 <- subset(all_stations_annual,lat_range=='49to51',c(3,4,5,6,7,8,9))
all_summer_47to49 <- subset(all_stations_summer,lat_range=='47to49',c(3,4,5,6,7,8,9))
all_summer_49to51 <- subset(all_stations_summer,lat_range=='49to51',c(3,4,5,6,7,8,9))

#Same for the 2 regions
tor<-toronto_annual[,c(2,3,4,5,6,7,8)]
tor_summer<-toronto_summer[,c(2,3,4,5,6,7,8)]
tor_daily<-toronto_summer[,c(2,3,4,5,6,7)]

van<-vancouver_annual[,c(2,3,4,5,6,7,8)]
van_summer<-vancouver_summer[,c(2,3,4,5,6,7,8)]

#Examine the correlations
cor(tor)
cor(tor_summer)
cor(van)
cor(van_summer)
cor(all_47to49)
cor(all_49to51)
cor(all_summer_47to49)
cor(all_summer_49to51)


#Annual data
head(tor,5)
summary(lm(tor$daily_max_temp_avg ~ tor$co2_ppm))
summary(lm(tor$daily_max_temp_avg ~ tor$avg_toa_insolation))
summary(lm(tor$daily_max_temp_avg ~ tor$avg_sky_ins))


summary(lm(van$daily_max_temp_avg ~ van$co2_ppm))
summary(lm(van$daily_max_temp_avg ~ van$avg_toa_insolation))
summary(lm(van$daily_max_temp_avg ~ van$avg_sky_ins))

summary(lm(all_47to49$daily_max_temp_avg ~ all_47to49$co2_ppm))
summary(lm(all_47to49$daily_max_temp_avg ~ all_47to49$avg_toa_insolation))

summary(lm(all_49to51$daily_max_temp_avg ~ all_49to51$co2_ppm))
summary(lm(all_49to51$daily_max_temp_avg ~ all_49to51$avg_toa_insolation))

#Summer data
head(tor_summer,5)
summary(lm(tor_summer$summer_max_temp_avg ~ tor_summer$co2_ppm))
summary(lm(tor_summer$summer_max_temp_avg ~ tor_summer$summer_avg_toa_insolation))
summary(lm(tor_summer$summer_max_temp_avg ~ tor_summer$summer_avg_sky_insolation))

summary(lm(van_summer$summer_max_temp_avg ~ van_summer$co2_ppm))
summary(lm(van_summer$summer_max_temp_avg ~ van_summer$summer_avg_toa_insolation))
summary(lm(van_summer$summer_max_temp_avg ~ van_summer$summer_avg_sky_insolation))

summary(lm(all_summer_47to49$summer_max_temp_avg ~ all_summer_47to49$co2_ppm))
summary(lm(all_summer_47to49$summer_max_temp_avg ~ all_summer_47to49$summer_avg_toa_insolation))

summary(lm(all_summer_49to51$summer_max_temp_avg ~ all_summer_49to51$co2_ppm))
summary(lm(all_summer_49to51$summer_max_temp_avg ~ all_summer_49to51$summer_avg_toa_insolation))

corrplot(cor(all_47to49))
corrplot(cor(all_49to51))
corrplot(cor(all_summer_47to49))
corrplot(cor(all_summer_49to51))
corrplot(cor(tor))
corrplot(cor(tor_summer))
corrplot(cor(tor_daily))
corrplot(cor(van))
corrplot(cor(van_summer))



#Focus on one set
head(all_summer_49to51,5)
attach(all_summer_49to51)

summary(lm(all_summer_49to51$summer_mean_temp_avg ~ all_summer_49to51$co2_ppm))
summary(lm(summer_mean_temp_avg ~ summer_avg_sky_insolation))
summary(lm(summer_mean_temp_avg ~ summer_avg_toa_insolation))





corrplot(cor(all_summer_47to49), type="upper", , 
          sig.level = 0.01,tl.col="black", tl.srt=45,title="
         Latitudes47to49 summer months" )

corrplot(cor(all_summer_49to51), type="upper", , 
         sig.level = 0.01,tl.col="black", tl.srt=45,title="
         Latitudes49to51 summer months" )

corrplot(cor(tor_summer), type="upper", , 
         sig.level = 0.01,tl.col="black", tl.srt=45,title="
         Toronto summer months" )

corrplot(cor(van_summer), type="upper", , 
         sig.level = 0.01,tl.col="black", tl.srt=45,title="
         Vancouver summer months" )


scatter.smooth(x=summer_mean_temp_avg, y=co2_ppm, main="Temp ~ CO2")  # scatterplot
scatter.smooth(x=summer_mean_temp_avg, y=summer_avg_toa_insolation, main="Temp ~ Solar")  # scatterplot


ggscatter(all_summer_49to51, x = "summer_mean_temp_avg", y = "summer_avg_sky_insolation", 
          add = "reg.line", conf.int = TRUE, cor.coef = TRUE, cor.method = "pearson",
          xlab = "Avg Summer Temperature, Celcius", ylab = "Ground Level Solar")


ggscatter(all_summer_49to51, x = "summer_mean_temp_avg", y = "summer_avg_toa_insolation", 
          add = "reg.line", conf.int = TRUE, cor.coef = TRUE, cor.method = "pearson",
          xlab = "Avg Summer Temperature, Celcius", ylab = "Solar Activity")


ggscatter(all_summer_49to51, x = "summer_mean_temp_avg", y = "co2_ppm", 
          add = "reg.line", conf.int = TRUE, cor.coef = TRUE, cor.method = "pearson",
          xlab = "Avg Summer Temperature, Celcius", ylab = "Carbon Dioxide")


shapiro.test(summer_mean_temp_avg) #p-value = 0.7702
shapiro.test(co2_ppm) #p-value = 0.1149
shapiro.test(summer_avg_toa_insolation) #p-value = 0.0009933


#Now Just Toronto
head(tor,5)
attach(tor_summer)

summary(lm(summer_mean_temp_avg ~ co2_ppm))
summary(lm(summer_mean_temp_avg ~ avg_sky_ins))
summary(lm(summer_mean_temp_avg ~ avg_toa_insolation))

summary(lm(daily_max_temp_avg ~ co2_ppm))
summary(lm(daily_max_temp_avg ~ avg_sky_ins))
summary(lm(daily_max_temp_avg ~ avg_toa_insolation))



scatter.smooth(x=daily_mean_temp_avg, y=co2_ppm, main="Temp ~ CO2")  # scatterplot
scatter.smooth(x=daily_mean_temp_avg, y=avg_toa_insolation, main="Temp ~ Solar")  # scatterplot


ggscatter(tor, x = "daily_mean_temp_avg", y = "avg_sky_ins", 
          add = "reg.line", conf.int = TRUE, cor.coef = TRUE, cor.method = "pearson",
          xlab = "Avg Summer Temperature, Celcius", ylab = "Ground Level Solar")


ggscatter(tor, x = "daily_mean_temp_avg", y = "avg_toa_insolation", 
          add = "reg.line", conf.int = TRUE, cor.coef = TRUE, cor.method = "pearson",
          xlab = "Avg Summer Temperature, Celcius", ylab = "Solar Activity")


ggscatter(tor, x = "daily_mean_temp_avg", y = "co2_ppm", 
          add = "reg.line", conf.int = TRUE, cor.coef = TRUE, cor.method = "pearson",
          xlab = "Avg Summer Temperature, Celcius", ylab = "Carbon Dioxide")


shapiro.test(daily_mean_temp_avg) #p-value = 0.07504
shapiro.test(co2_ppm) #p-value = 0.1149
shapiro.test(avg_toa_insolation) #p-value = 5.342e-07



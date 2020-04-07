create table toronto_100_day (
num int (10), 
station_name varchar(255),
station_id int(10),
station_operator varchar(22),
prov varchar(5),
lat decimal(8,2),
lon decimal(8,2),
elev int(8),
climate_id int(22),
WMO_id int(22),
TC_id int(22),
date date,
year int(5),
month int(5),
day int(5),
qual varchar(255),
cool_deg_days decimal(10,2),
cool_deg_days_flag varchar(22),
dir_max_gust varchar(22),
dir_max_gust_flag varchar(22),
heat_deg_days decimal(10,2),
heat_deg_days_flag varchar(22),
max_temp decimal(10,2),
max_temp_flag varchar(22),
mean_temp decimal(10,2),
mean_temp_flag varchar(22),
min_temp decimal(10,2),
min_temp_flag varchar(22),
snow_grnd decimal(10,2),
snow_grnd_flag varchar(22),
spd_max_gust decimal(10,2),
spd_max_gust_flag varchar(22),
total_precip decimal(10,2),
total_precip_flag varchar(22),
total_rain decimal(10,2),
total_rain_flag varchar(22),
total_snow decimal(10,2),
total_snow_flag varchar(22)
);

create table toronto_100_month (
num int (10), 
station_name varchar(255),
station_id int(10),
station_operator varchar(22),
prov varchar(5),
lat decimal(8,2),
lon decimal(8,2),
elev int(8),
climate_id int(22),
WMO_id int(22),
TC_id int(22),
date date,
year int(5),
month int(5),
day int(5),
qual varchar(255),
cool_deg_days decimal(10,2),
cool_deg_days_flag varchar(22),
dir_max_gust varchar(22),
dir_max_gust_flag varchar(22),
heat_deg_days decimal(10,2),
heat_deg_days_flag varchar(22),
max_temp decimal(10,2),
max_temp_flag varchar(22),
mean_temp decimal(10,2),
mean_temp_flag varchar(22),
min_temp decimal(10,2),
min_temp_flag varchar(22),
snow_grnd decimal(10,2),
snow_grnd_flag varchar(22),
spd_max_gust decimal(10,2),
spd_max_gust_flag varchar(22),
total_precip decimal(10,2),
total_precip_flag varchar(22),
total_rain decimal(10,2),
total_rain_flag varchar(22),
total_snow decimal(10,2),
total_snow_flag varchar(22)
);

create table all_stations_month (
num int (10), 
station_name varchar(255),
station_id int(10),
station_operator varchar(22),
prov varchar(5),
lat decimal(8,2),
lon decimal(8,2),
elev int(8),
climate_id int(22),
WMO_id int(22),
TC_id int(22),
date date,
year int(5),
month int(5),
day int(5),
qual varchar(255),
cool_deg_days decimal(10,2),
cool_deg_days_flag varchar(22),
dir_max_gust varchar(22),
dir_max_gust_flag varchar(22),
heat_deg_days decimal(10,2),
heat_deg_days_flag varchar(22),
max_temp decimal(10,2),
max_temp_flag varchar(22),
mean_temp decimal(10,2),
mean_temp_flag varchar(22),
min_temp decimal(10,2),
min_temp_flag varchar(22),
snow_grnd decimal(10,2),
snow_grnd_flag varchar(22),
spd_max_gust decimal(10,2),
spd_max_gust_flag varchar(22),
total_precip decimal(10,2),
total_precip_flag varchar(22),
total_rain decimal(10,2),
total_rain_flag varchar(22),
total_snow decimal(10,2),
total_snow_flag varchar(22)
);

create table all_stations_day (
num int (10), 
station_name varchar(255),
station_id int(10),
station_operator varchar(22),
prov varchar(5),
lat decimal(8,2),
lon decimal(8,2),
elev int(8),
climate_id int(22),
WMO_id int(22),
TC_id int(22),
date date,
year int(5),
month int(5),
day int(5),
qual varchar(255),
cool_deg_days decimal(10,2),
cool_deg_days_flag varchar(22),
dir_max_gust varchar(22),
dir_max_gust_flag varchar(22),
heat_deg_days decimal(10,2),
heat_deg_days_flag varchar(22),
max_temp decimal(10,2),
max_temp_flag varchar(22),
mean_temp decimal(10,2),
mean_temp_flag varchar(22),
min_temp decimal(10,2),
min_temp_flag varchar(22),
snow_grnd decimal(10,2),
snow_grnd_flag varchar(22),
spd_max_gust decimal(10,2),
spd_max_gust_flag varchar(22),
total_precip decimal(10,2),
total_precip_flag varchar(22),
total_rain decimal(10,2),
total_rain_flag varchar(22),
total_snow decimal(10,2),
total_snow_flag varchar(22)
);


load data local infile 'C:/data_analytics/climate/toronto_100_day_data.csv' into table toronto_100_day fields 
terminated by ',' OPTIONALLY ENCLOSED by '"' lines terminated by '\r' ignore 1 lines;

load data local infile 'C:/data_analytics/climate/toronto_100_month_data.csv' into table toronto_100_month fields 
terminated by ',' OPTIONALLY ENCLOSED by '"' lines terminated by '\r' ignore 1 lines;

load data local infile 'C:/data_analytics/climate/lat40_day_data.csv' into table all_stations_day fields 
terminated by ',' OPTIONALLY ENCLOSED by '"' lines terminated by '\r' ignore 1 lines;
load data local infile 'C:/data_analytics/climate/lat50_day_data.csv' into table all_stations_day fields 
terminated by ',' OPTIONALLY ENCLOSED by '"' lines terminated by '\r' ignore 1 lines;
load data local infile 'C:/data_analytics/climate/lat60_day_data.csv' into table all_stations_day fields 
terminated by ',' OPTIONALLY ENCLOSED by '"' lines terminated by '\r' ignore 1 lines;

load data local infile 'C:/data_analytics/climate/lat40_month_data.csv' into table all_stations_month fields 
terminated by ',' OPTIONALLY ENCLOSED by '"' lines terminated by '\r' ignore 1 lines;
load data local infile 'C:/data_analytics/climate/lat50_month_data.csv' into table all_stations_month fields 
terminated by ',' OPTIONALLY ENCLOSED by '"' lines terminated by '\r' ignore 1 lines;
load data local infile 'C:/data_analytics/climate/lat60_month_data.csv' into table all_stations_month fields 
terminated by ',' OPTIONALLY ENCLOSED by '"' lines terminated by '\r' ignore 1 lines;




create table co2_levels (
year int(5), 
co2_ppm decimal(10,2), 
uncertainty decimal(10,2)
);

create table solar_levels_toronto (
year int(5), 
Jan decimal(10,2),
Feb decimal(10,2),
Mar decimal(10,2),
Apr decimal(10,2),
May decimal(10,2),
Jun decimal(10,2),
Jul decimal(10,2),
Aug decimal(10,2),
Sep decimal(10,2),
Oct decimal(10,2),
Nov decimal(10,2),
`Dec` decimal(10,2), 
annual decimal(10,2)
);

load data local infile 'C:/data_analytics/climate/CO2.csv' into table co2_levels fields 
terminated by ','  lines terminated by '\n' ignore 1 lines;
load data local infile 'C:/data_analytics/climate/solar_to.csv' into table solar_levels_toronto fields 
terminated by ','  lines terminated by '\n' ignore 1 lines;





#Main populated latitude range data
select year(date), avg(lat) as avg_lat, 
count(distinct station_id) as stations_used, avg(if(max_temp!=0, max_temp, null)) as avg_max_temp, 
avg(if(mean_temp!=0, max_temp, null)) as avg_mean_temp , max(max_temp) as max_temp, 
avg(if(max_temp!=0 and month in (7,8), max_temp, null)) as avg_max_summer_temp,
max(if(max_temp!=0 and month in (7,8), max_temp, null)) as max_max_summer_temp, co2_ppm
from all_stations_month a
left join co2_levels c on year(a.date)=c.year
where lat>43 and lat<50
group by year(date) 
order by  year(date);


#Toronto data
select year(date), count(distinct station_id) as stations_used, avg(if(max_temp!=0, max_temp, null)) as avg_max_temp, 
avg(if(mean_temp!=0, max_temp, null)) as avg_mean_temp , max(max_temp) as max_temp, min(min_temp) as min_temp, 
avg(if(max_temp!=0 and month in (7,8), max_temp, null)) as avg_max_summer_temp,
max(if(max_temp!=0 and month in (7,8), max_temp, null)) as max_max_summer_temp.
co2_ppm, s.annual as annual_solar, (s.Jul+s.Aug)/2 as summer_solar
from toronto_100_day t 
left join solar_levels_toronto s on year(t.date)=s.year
left join co2_levels c on year(t.date)=c.year
where t.date is not null and year(t.date)>=1980
group by year(date)
order by  year(date);

#Export both results to CSV format;  main_set.csv  & toronto_set.csv
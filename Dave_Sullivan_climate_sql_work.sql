create table toronto_200 (
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

create table vancouver_200 (
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

create table all_stations (
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


load data local infile 'C:/GIT/climate/data/toronto_200_data.csv' into table toronto_200 fields 
terminated by ',' OPTIONALLY ENCLOSED by '"' lines terminated by '\r' ignore 1 lines;

load data local infile 'C:/GIT/climate/data/vancouver_200_data.csv' into table vancouver_200 fields 
terminated by ',' OPTIONALLY ENCLOSED by '"' lines terminated by '\r' ignore 1 lines;

load data local infile 'C:/GIT/climate/data/all_stations_data.csv' into table all_stations fields 
terminated by ',' OPTIONALLY ENCLOSED by '"' lines terminated by '\r' ignore 1 lines;


create table co2_levels (
year int(5), 
co2_ppm decimal(10,2), 
uncertainty decimal(10,2)
);

create table solar_rad_global (
`date` date, 
Radiation decimal(10,2), 
STD decimal(10,2)
);

create table toronto_solar (
lat decimal(10,2), 
lon decimal(10,2), 
year int(5), 
doy int(5), 
therm_flux decimal(10,2),
sky_insolation decimal(10,2),
toa_insolation decimal(10,2)
);

create table vancouver_solar (
lat decimal(10,2), 
lon decimal(10,2), 
year int(5), 
doy int(5), 
therm_flux decimal(10,2),
sky_insolation decimal(10,2),
toa_insolation decimal(10,2)
);

load data local infile 'C:/data_analytics/climate/solar_daily_toronto.csv' into table toronto_solar fields 
terminated by ','  lines terminated by '\n' ignore 1 lines;
load data local infile 'C:/GIT/climate/data/solar_daily_vancouver.csv' into table vancouver_solar fields 
terminated by ','  lines terminated by '\n' ignore 1 lines;

alter table toronto_solar add column date date, add index(date);
alter table vancouver_solar add column date date, add index(date);

load data local infile 'C:/GIT/climate/data/CO2_annual.csv' into table co2_levels fields 
terminated by ','  lines terminated by '\n' ignore 1 lines;
load data local infile 'C:/GIT/climate/data/satellite_solar_data.csv' into table solar_rad_global fields 
terminated by ',' OPTIONALLY ENCLOSED by '"' lines terminated by '\r' ignore 1 lines;

alter table toronto_solar  add index(date);
alter table vancouver_solar  add index(date);

update toronto_solar set date=concat(makedate(year, doy));
update vancouver_solar set date=concat(makedate(year, doy));











alter table all_stations add index(date), add index(station_id);
alter table toronto_200 add index(date), add index(station_id);
alter table vancouver_200 add index(date), add index(station_id);

#Figure out the latitude range groupings
select round(lat, 0) as latt, count(distinct station_id) as stations from all_stations group by latt order by latt;

select case when lat<46 then 'under46' when lat>=46 and lat<47 then '46to47' when lat>=47 and lat<49 then '47to49'
when lat>=49 and lat<51 then '49to51'when lat>=51 and lat<54 then '51to54' else '54andup' end as lat_range,
 count(distinct station_id) as stations_used
 from all_stations as2 group by lat_range;
 
#Main populated latitude range aggregated annual
create table all_stations_annual
select year(a.date) as year, avg(a.lat) as avg_lat, 
case when a.lat<46 then 'under46' when a.lat>=46 and a.lat<47 then '46to47' when a.lat>=47 and a.lat<49 then '47to49'
when a.lat>=49 and a.lat<51 then '49to51'when a.lat>=51 and a.lat<54 then '51to54' else '54andup' end as lat_range,
count(distinct station_id) as stations_used, avg(if(max_temp!=0, max_temp, null)) as daily_max_temp_avg, 
avg(if(mean_temp!=0, max_temp, null)) as daily_mean_temp_avg , max(max_temp) as max_annual_temp, 
avg(if(max_temp!=0 and month in (7,8), max_temp, null)) as summer_max_temp_avg,
avg(if(mean_temp!=0 and month in (7,8), mean_temp, null)) as summer_mean_temp_avg,
max(if(max_temp!=0 and month in (7,8), max_temp, null)) as summer_max_temp
from all_stations  a
where a.date is not null
group by lat_range,year(date) 
order by  lat_range,
year(a.date);


#Toronto stations aggregated daily
create table toronto_daily
select a.date, avg(a.lat) as avg_lat, 
count(distinct station_id) as stations_used, avg(if(max_temp!=0, max_temp, null)) as daily_max_temp_avg, 
avg(if(mean_temp!=0, max_temp, null)) as daily_mean_temp_avg , max(max_temp) as max_daily_temp 
from toronto_200 a
where date is not null
group by date 
order by a.date;

#Toronto stations aggregated annual
create table toronto_annual
select year(a.date) as year, avg(a.lat) as avg_lat, 
count(distinct station_id) as stations_used, avg(if(max_temp!=0, max_temp, null)) as daily_max_temp_avg, 
avg(if(mean_temp!=0, max_temp, null)) as daily_mean_temp_avg , max(max_temp) as max_annual_temp, 
avg(if(max_temp!=0 and month in (7,8), max_temp, null)) as summer_max_temp_avg,
avg(if(mean_temp!=0 and month in (7,8), mean_temp, null)) as summer_mean_temp_avg,
max(if(max_temp!=0 and month in (7,8), max_temp, null)) as summer_max_temp
from toronto_200 a
where date is not null
group by year(date) 
order by year(a.date);

#Vancouver stations aggregated daily
create table vancouver_daily
select a.date, avg(a.lat) as avg_lat, 
count(distinct station_id) as stations_used, avg(if(max_temp!=0, max_temp, null)) as daily_max_temp_avg, 
avg(if(mean_temp!=0, max_temp, null)) as daily_mean_temp_avg , max(max_temp) as max_daily_temp 
from vancouver_200 a
where date is not null
group by date 
order by a.date;

#Vancouver stations aggregated annual
create table vancouver_annual
select year(a.date) as year, avg(a.lat) as avg_lat, 
count(distinct station_id) as stations_used, avg(if(max_temp!=0, max_temp, null)) as daily_max_temp_avg, 
avg(if(mean_temp!=0, max_temp, null)) as daily_mean_temp_avg , max(max_temp) as max_annual_temp, 
avg(if(max_temp!=0 and month in (7,8), max_temp, null)) as summer_max_temp_avg,
avg(if(mean_temp!=0 and month in (7,8), mean_temp, null)) as summer_mean_temp_avg,
max(if(max_temp!=0 and month in (7,8), max_temp, null)) as summer_max_temp
from vancouver_200  a
where date is not null
group by year(date) 
order by year(a.date);




#Toronto solar aggreagated annual
create table toronto_solar_annual
select year(t.date) as year, 
avg(t.therm_flux) as avg_therm_flux, 
avg(if(month(t.date) in (7,8), t.therm_flux, null)) as summer_avg_therm_flux,
avg(t.sky_insolation) as avg_sky_ins, 
avg(if(month(t.date) in (7,8), t.sky_insolation, null)) as summer_avg_sky_insolation,
avg(t.toa_insolation) as avg_toa_insolation, 
avg(if(month(t.date) in (7,8), t.toa_insolation, null)) as summer_avg_toa_insolation
from toronto_solar t
where year(date)>=1984 and year(date)<=2019
group by year(t.date) 
order by year(t.date);



#Vancouver solar aggreagated annual
create table vancouver_solar_annual
select year(v.date) as year,
avg(v.therm_flux) as avg_therm_flux, 
avg(if(month(v.date) in (7,8), v.therm_flux, null)) as summer_avg_therm_flux,
avg(v.sky_insolation) as avg_sky_ins, 
avg(if(month(v.date) in (7,8), v.sky_insolation, null)) as summer_avg_sky_insolation,
avg(v.toa_insolation) as avg_toa_insolation, 
avg(if(month(v.date) in (7,8), v.toa_insolation, null)) as summer_avg_toa_insolation
from vancouver_solar v 
where year(date)>=1984 and year(date)<=2019
group by year(v.date) order by year(v.date);





#TOronto daily data export
select td.date, daily_max_temp_avg, daily_mean_temp_avg, max_daily_temp,
therm_flux, sky_insolation, toa_insolation 
#INTO OUTFILE 'toronto_daily.csv' FIELDS TERMINATED BY ',' ENCLOSED BY '"'  LINES TERMINATED BY '\n' 
from toronto_daily td 
 join toronto_solar ts on td.date=ts.date
group by td.date;


#All annual data export
select lat_range, t.year, daily_max_temp_avg, daily_mean_temp_avg, max_annual_temp, 
avg_therm_flux, avg_sky_ins, avg_toa_insolation,
co2_ppm
INTO OUTFILE 'vancouver_annual.csv' FIELDS TERMINATED BY ',' ENCLOSED BY '"'  LINES TERMINATED BY '\n' 
from all_stations_annual t
join toronto_solar_annual tsa on t.year=tsa.year
left join co2_levels c on t.year=c.year
group by lat_range, t.year;

#All summer data export
select lat_range, t.year,
summer_max_temp_avg, summer_mean_temp_avg, summer_max_temp, 
summer_avg_therm_flux,summer_avg_sky_insolation, summer_avg_toa_insolation,
co2_ppm
INTO OUTFILE 'vancouver_annual.csv' FIELDS TERMINATED BY ',' ENCLOSED BY '"'  LINES TERMINATED BY '\n' 
from all_stations_annual t
join toronto_solar_annual tsa on t.year=tsa.year
left join co2_levels c on t.year=c.year
group by lat_range, t.year;



#Toronto annual data export
select t.year, daily_max_temp_avg, daily_mean_temp_avg, max_annual_temp, 
avg_therm_flux, avg_sky_ins, avg_toa_insolation,
co2_ppm
INTO OUTFILE 'vancouver_annual.csv' FIELDS TERMINATED BY ',' ENCLOSED BY '"'  LINES TERMINATED BY '\n' 
from toronto_annual t
join toronto_solar_annual tsa on t.year=tsa.year
left join co2_levels c on t.year=c.year;

#Toronto summer data export
select t.year,
summer_max_temp_avg, summer_mean_temp_avg, summer_max_temp, 
summer_avg_therm_flux,summer_avg_sky_insolation, summer_avg_toa_insolation,
co2_ppm
INTO OUTFILE 'vancouver_annual.csv' FIELDS TERMINATED BY ',' ENCLOSED BY '"'  LINES TERMINATED BY '\n' 
from toronto_annual t
join toronto_solar_annual tsa on t.year=tsa.year
left join co2_levels c on t.year=c.year;

#Vancouver annual data export
select v.year, daily_max_temp_avg, daily_mean_temp_avg, max_annual_temp, 
avg_therm_flux, avg_sky_ins, avg_toa_insolation,
co2_ppm
INTO OUTFILE 'vancouver_annual.csv' FIELDS TERMINATED BY ',' ENCLOSED BY '"'  LINES TERMINATED BY '\n' 
from vancouver_annual v
join vancouver_solar_annual vsa on v.year=vsa.year
left join co2_levels c on v.year=c.year;

#Vancouver summer data export
select v.year,
summer_max_temp_avg, summer_mean_temp_avg, summer_max_temp, 
summer_avg_therm_flux,summer_avg_sky_insolation, summer_avg_toa_insolation,
co2_ppm 
INTO OUTFILE 'vancouver_summer.csv' FIELDS TERMINATED BY ',' ENCLOSED BY '"' LINES TERMINATED BY '\n' 
from vancouver_annual v
join vancouver_solar_annual vsa on v.year=vsa.year
left join co2_levels c on v.year=c.year;



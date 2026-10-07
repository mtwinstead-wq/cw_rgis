# vector 2 spatia; join
if (!require(pacman)) install.packages("pacman")

pacman::p_load(tidyverse,
               sf,
               mapview)

rm(list=ls())


sf_site<-readRDS("data/sf_finsync_nc.rds")

sf_nc_county<-readRDS("data/sf_nc_county.rds")

#visualize
mapview(sf_nc_county,legend=FALSE)+mapview(sf_site)

#join county infomation to sf_site
sf_site_join<-st_join(x=sf_site,y=sf_nc_county)

#count the number of fish survey sites within guilford county

sf_site_guilford<-sf_site_join%>%filter(county=="guilford")

sf_site_clay<-sf_site_join%>%filter(county=="clay")

sf_str<-readRDS("data/sf_stream_gi.rds")

sf_gi_county<-sf_nc_county%>%filter(county=="guilford")
ggplot()

ggplot()+
  geom_sf(data=sf_gi_county)+
  geom_sf(data=sf_str)+
  geom_sf(data=sf_site_guilford)

sf_str_proj<-st_transform(sf_str,crs=32617)

v_str_l<-st_length(sf_str_proj)

head(v_str_l)

sf_str_w_len<-sf_str%>%mutate(length=v_str_l)

sf_nc_county_proj<-st_transform(sf_nc_county,crs=32617)

v_area<-st_area(sf_nc_county_proj)



sf_nc_county_w_area<-sf_nc_county_proj %>%
  mutate(area=as.numeric(v_area)/1E+6) %>%
  arrange(desc(area))

sf_county1k<-sf_nc_county_w_area%>%filter(area>1000)

ggplot()+geom_sf(data=sf_county1k)


#Q1
sf_quakes<-readRDS("data/sf_quakes.rds")

sf_nz<-readRDS("data/sf_nz.rds")

sf_quakes_join<-st_join(sf_quakes,sf_nz)

sf_quakes_nz<-sf_quakes_join%>%drop_na(fid)






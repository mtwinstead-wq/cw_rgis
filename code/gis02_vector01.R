# vector 1
if (!require(pacman)) install.packages("pacman")

pacman::p_load(tidyverse,
               sf,
               mapview)

rm(list=ls())

#SHAPE format
#how to read vector data
sf_nc_county<-st_read(dsn="data/nc.shp",quiet=TRUE)

##How to export shape files
st_write(sf_nc_county,dsn="data/sf_nc_county.shp",append=FALSE)

##RDS format
saveRDS(sf_nc_county,file="data/sf_nc_county.rds")

sf_nc_county<-readRDS(file="data/sf_nc_county.rds")


#POINT
#read point vector data

sf_site<-readRDS("data/sf_finsync_nc.rds")

#point's fill color
mapview(sf_site,col.regions="black",legend=FALSE)

#select the first 10
sf_site_f10<-sf_site%>%slice(1:10)

mapview(sf_site_f10,col.regions="red",legend=FALSE)


#Line

sf_str<-readRDS("data/sf_stream_gi.rds")


mapview(sf_str,color="blue",legend=FALSE)

#polygon

sf_nc_county<-readRDS("data/sf_nc_county.rds")

mapview(sf_nc_county,col.regions="pink",legend=FALSE)



sf_nc_gi<-sf_nc_county%>%filter(county=="guilford")


mapview(sf_nc_gi,col.regions="green",legend=FALSE)

#static map in ggplot format

ggplot()+geom_sf(data=sf_nc_county)

ggplot()+geom_sf(data=sf_nc_county)+geom_sf(data=sf_str)

ggplot()+geom_sf(data=sf_nc_county)+geom_sf(data=sf_str)+geom_sf(data=sf_site)


#Q1
sf_str_as<-readRDS(file="data/sf_stream_as.rds")



#Q2
st_crs(sf_str_as)

st_crs(sf_nc_county)

identical(sf_str_as,sf_nc_county)

#Q3
ggplot()+geom_sf(data=sf_nc_county)+geom_sf(data=sf_str_as)



#Q4

sf_nc_as<-sf_nc_county%>%filter(county=="ashe")

ggplot()+geom_sf(data=sf_nc_as)+geom_sf(data=sf_str_as)













#raster 1:basic terra operation

if (!require(pacman)) install.packages("pacman")

pacman::p_load(tidyverse,
               terra,
               tidyterra,
               mapview,
               stars)
#rast is a function to read data from your directory
(spr_ex<-rast("data/spr_example.tif"))

writeRaster(x=spr_ex,filename="data/spr_elev.tif",overwrite=TRUE)

ggplot()+geom_spatraster(data=spr_ex)


star_ex<-st_as_stars(spr_ex)
mapview(star_ex)







v_elev<-values(spr_ex)

extract(spr_ex,y=cbind(6.0000,50.0000))

extract(spr_ex,y=cbind(25.00,5.00))
extract(spr_ex,y=cbind(10.000,15.000))
extract(spr_ex,y=cbind(300.00,200.00))

df_point<-tibble(lon=c(6,5.9),lat=c(50,49.96))

extract(spr_ex,y=df_point)




spr_for<-rast("data/spr_forest_nc.tif")

ggplot()+geom_spatraster(data=spr_for)

unique(spr_for)

v_binary<-values(spr_for)
mean(v_binary)*100


spr_land<-rast("data/spr_land_reclass.tif")
unique(spr_land)

extract(spr_land,y=cbind(-79.8063,36.0701))

cm<-cbind(c(0,1001,1010,1100),c(0,1,0,0))

spr_bin<-classify(spr_land,rcl=cm)

unique(spr_bin)

v_bin<-values(spr_bin)
mean(v_bin)*100

cm_crop<-cbind(c(0,1001,1010,1100),c(0,0,1,0))

classify(x=spr_land,rcl=cm_crop)

spr_crop<-classify(x=spr_land,rcl=cm_crop)

v_crop<-values(spr_crop)
mean(v_crop)*100

cm_urban<-cbind(c(0,1001,1010,1100),c(0,0,0,1))

spr_urban<-classify(spr_land,rcl=cm_urban)

unique(spr_urban)
v_urban<-values(spr_urban)
mean(v_urban)*100


#Exercise

#Q1 
spr_prec_ncne<-rast("data/spr_prec_ncne.tif")

#Q2
#long extent = -79.89181,-75.45847
#lat extent = 35.24153,36.59153
#CRS = WGS84
#min max precipitation = 1063.1-1501

#Q3
ggplot()+geom_spatraster(data=spr_prec_ncne)

sf_site<-readRDS("data/sf_finsync_nc.rds")

df_xy<-st_coordinates(sf_site)

df_land<-extract(spr_land,df_xy)

#forest
df_land%>%
  filter(code==1001)%>%
  nrow()

#cropland
df_land%>%
  filter(code==1010)%>%
  nrow()

#urban
df_land%>%
  filter(code==1100)%>%
  nrow()

#quicker approach
table(df_land)

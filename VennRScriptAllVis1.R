#RESHAPE DATA FOR ANALYSIS BY USE uganda 2014-2015
#From the reshape package http://had.co.nz/reshape/

rawug_orn <-
  read.csv("AllRawNoWeeds_v7.csv") #dataframe of first visit only

#remove ornaments,and visit2 counts
rawug <- rawug_orn[which(
  rawug_orn$PrimaryUseOrnament < '1'
  & rawug_orn$count1stVisit_numberround_ > '0'
  &
    rawug_orn$FullDescription > '0'
), ] #exclude ornamentals and unidentified

raw <-
  rawug[c(3, 16, 170)] #District=3 BotanicalName=16 one=170 22=countsvisit1

library(plyr)

rawug.df <- ddply(raw,
                  c("District", "BotanicalName"),
                  summarise,
                  sum.plants = sum(one))
library(reshape)

ugvennmelt <-
  melt(rawug.df, id = c("District", "BotanicalName", measured = c("sum.plants")))

names(ugvennmelt)

ugvenncast <- cast(ugvennmelt,   BotanicalName ~ District, sum)

# plot the diagram:
#Proportional Plot

par(family = "serif")
library(venneuler)
su <- venneuler(
  c(
    Bushenyi = 37,
    Sheema = 10,
    Rubirizi = 38,
    "Bushenyi&Sheema" = 18,
    "Bushenyi&Rubirizi" = 24,
    "Sheema&Rubirizi" = 15 ,
    "Bushenyi&Sheema&Rubirizi" = 68
  )
)
#su$labels <- c('Bushenyi', 'Sheema', 'Rubirizi')#####
su$labels <- c(paste(""), #  to include counts \n ,59+24+26+71),
               paste(""), # to include counts ,19+24+17+71),
               paste("")# to include counts ,,50+26+17+71))
               plot(su, col = c("red", "blue", "green"))
               

#RESHAPE DATA FOR ANALYSIS BY USE uganda 2014-2015
#From the reshape package http://had.co.nz/reshape/
setwd("/Users/macbook/Publications/15 Uganda Homegardens/R/VennDiagrams")

rawug_orn<-read.csv("~/AllRawNoWeeds.csv")
#remove ornaments,unidentifiedplants, and visit2 counts
rawug <- rawug_orn[ which(rawug_orn$PrimaryUseOrnament<'1'  
                          & rawug_orn$count1stVisit_numberround_>'0'),]

  #select only exotics
rawexot <- rawug[ which(rawug$native=='0'), ]
rawexo <- rawexot[c(3,16,173)] #District=3 BotanicalName=16 nativey1=35 one=173
library(plyr)
rawugexo.df <- ddply(rawexo, c("District", "BotanicalName"), summarise,
                     sum.plants=sum(one))
library(reshape) 
ugvennexomelt<-melt(rawugexo.df, id = c("District", "BotanicalName", measured = c("sum.plants")))
names(ugvennexomelt)
ugvennexocast<-cast(ugvennexomelt,  BotanicalName ~ District, sum)
vennexo <- ugvennexocast[2:4]
library(limma)
countexo <- vennCounts(vennexo)
colnames(countexo) <- c('Bushenyi', 'Rubirizi', 'Sheema', 'Counts')
# plot the diagram:
par(family="serif") 
vennDiagram(countexo, names=c('Bushenyi', 'Rubirizi', 'Sheema'), 
            cex = 1, lwd = 1,circle.col=c("red","green","blue"))


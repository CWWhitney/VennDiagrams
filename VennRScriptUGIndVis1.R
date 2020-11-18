#RESHAPE DATA FOR ANALYSIS BY USE uganda 2014-2015
#From the reshape package http://had.co.nz/reshape/
setwd("/Users/macbook/Publications/15 Uganda Homegardens/R/VennDiagrams")

rawug_orn<-read.csv("~/AllRawNoWeeds.csv")
#remove ornaments, , and visit2 counts, optional unidentifiedplants (& rawug_orn$FullDescription>'0')
rawug <- rawug_orn[ which(rawug_orn$PrimaryUseOrnament<'1' 
                          & rawug_orn$count1stVisit_numberround_>'0'),]

rawindt <- rawug[ which(rawug$native=='1'), ]
rawind <- rawindt[c(3,16,173)] #District=3 BotanicalName=16 nativey1=35 one=173
library(plyr)
rawugind.df <- ddply(rawind, c("District", "BotanicalName"), summarise,
                     sum.plants=sum(one))
library(reshape) 
ugvennindmelt<-melt(rawugind.df, id = c("District", "BotanicalName", measured = c("sum.plants")))
names(ugvennindmelt)
ugvennindcast<-cast(ugvennindmelt,BotanicalName~District, sum)
vennind <- ugvennindcast[2:4]

library(limma)
countind <- vennCounts(vennind)
colnames(countind) <- c('Bushenyi', 'Rubirizi', 'Sheema')
# plot the diagram:
par(family="serif") 
vennDiagram(countind, names=c('Bushenyi', 'Rubirizi', 'Sheema'), 
            cex = 1, lwd = 1,circle.col=c("red","green","blue"))

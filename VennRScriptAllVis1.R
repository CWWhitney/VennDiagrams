#RESHAPE DATA FOR ANALYSIS BY USE uganda 2014-2015
#From the reshape package http://had.co.nz/reshape/

rawug_orn <-
  read.csv("AllRawNoWeeds_v7.csv") #dataframe of visits to farms

#remove ornaments,and visit2 counts
rawug <- rawug_orn[which(
  rawug_orn$PrimaryUseOrnament < '1'
  & rawug_orn$count1stVisit_numberround_ > '0'
  &
    rawug_orn$FullDescription > '0'
), ] #exclude ornamentals and unidentified

#Subset for three ring Venn ####

raw <-
  rawug[c(3, 16, 170)] #District=3 BotanicalName=16 one=170 22=countsvisit1

# Load library
library(plyr)

rawug.df <- ddply(raw,
                  c("District", "BotanicalName"),
                  summarise,
                  sum.plants = sum(one))
# Load library
library(reshape)

ugvennmelt <-
  melt(rawug.df, id = c("District", "BotanicalName", measured = c("sum.plants")))

names(ugvennmelt)

ugvenncast <- cast(ugvennmelt,   BotanicalName ~ District, sum)


# Load library
               library(VennDiagram)

# Plot with three ring Venn ####
               venn.diagram(
                   x = list(ugvenncast$Bushenyi, ugvenncast$Rubirizi, ugvenncast$Sheema),
                 category.names = c("Bushenyi" , "Rubirizi" , "Sheema"),
                 filename = 'Venn_3_Regions.tiff',
                 height = 4,
                 width = 4,
                 output=TRUE
               )

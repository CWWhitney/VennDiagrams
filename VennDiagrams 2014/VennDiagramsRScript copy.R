#RESHAPE DATA FOR ANALYSIS BY USE uganda 2014-2015
#From the reshape package http://had.co.nz/reshape/

install.packages("reshape")
install.packages("ggplot2")
install.packages("dplyr")
#Load the massive data set (check excel preferences that the column names are numbers)
rawug<-read.csv("~/AllRawNoWeeds.csv")
names(rawug)
#create a new varaible in column 65 of the unixue botanical names
rawug$botname <- as.factor(as.numeric(rawug$BotanicalName))
rawug$stemsvisit1.<- as.numeric(rawug$count1stVisit.numberround.)
rawug$dist <- as.factor(as.numeric(rawug$District))
View(rawug)

#create new data set with only the variables for Venn ("dist""stemsvisit1.""botname")
#REMEMBER TO DETACH LATER detach(ugvenn)

ugvenn <- rawug[c(66,67,65)]

#make the botanical name into numbers so that R can read

names(ugvenn)
View(ugvenn)


#Reshape and get rid of missing values, if there are any, with na.rm = TRUE
library(reshape)
library(ggplot2)
library(dplyr)

#Before Melting and casting we need to aggregate #or plyr
library(plyr)
rawug.df <- ddply(ugvenn, c("dist", "botname"), summarise,
sum.stems=sum(ugvenn$stemsvisit1.))
View(rawug.df)

ugvennmelt<-melt(rawug.df, id = c("dist", "botname", measured = c("sum.stems")))
# The formula also calls for entry of measured variables but assumes they are all measured if you enter
# example text to follow the last id variable ", measured = c("age", "weight","height"))"

names(ugvennmelt)
View(ugvennmelt)

#create a new datasheet with district as header (botname) and botanical name as row label (dist) with stems (sum.stems) as sums
ugvenncast<-cast(ugvennmelt,  botname ~ dist, sum)
View(ugvenncast)
#or write table if you want to save it write.table(ugvenncast,"~/botnamemelt.rtf", sep="\t")

source("http://bioconductor.org/biocLite.R")
# Install the "limma" package
biocLite("limma")

# Load the package
library(limma)

# Now create the matrix with the presence/absence of species (1 for present and 0 for absent)

#create a matrix with count data for the presence or absence of  (all of the well over 200) plants 
  #(regions as header and no row labels for species)
venn<-read.csv("~/Publications/15 Uganda Homegardens/R/15 UgandaVennDiagrams/UgandaVennDiagramsDataVisit1.csv")

  # Count the number of species with only one region; with two specific species; and with and without the three regions.
  counts <- vennCounts(venn)

# plot the diagram:
vennDiagram(counts)

￼
#Again for introduced plants
vennint<-read.csv("~/Publications/15 Uganda Homegardens/R/15 UgandaVennDiagrams/gardenstats.venn.int.csv")
countsint <- vennCounts(vennint)
vennDiagram(countsint)

￼
#and indigenous
vennind<-read.csv("~/Publications/15 Uganda Homegardens/R/15 UgandaVennDiagrams/gardenstats.venn.ind.csv")
countsind <- vennCounts(vennind)
vennDiagram(countsind)

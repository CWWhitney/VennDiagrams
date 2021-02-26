source("http://bioconductor.org/biocLite.R")
# Install the "limma" package
biocLite("limma")

# Load the package
library(limma)

# Now create the matrix with the presence/absence of species

#create a matrix with count data for the presence or absence of  (all of the well over 200) plants (regions as header and no row labels for species)
venn<-read.csv("/Users/macbook/R/UgandaVennDiagrams/gardenstatsspvenn.csv")

  # Count the number of species with only one region; with two specific species; and with and without the three regions.
  counts <- vennCounts(venn)

# plot the diagram:
vennDiagram(counts)

￼
#Again for introduced plants
vennint<-read.csv("/Users/macbook/R/UgandaVennDiagrams/gardenstats.venn.int.csv")
countsint <- vennCounts(vennint)
vennDiagram(countsint)

￼
#and indigenous
vennind<-read.csv("/Users/macbook/R/UgandaVennDiagrams/gardenstats.venn.ind.csv")
countsind <- vennCounts(vennind)
vennDiagram(countsind)

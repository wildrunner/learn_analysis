dat <- read.table(text="
ISO3V10   Country   'No of Documents'    Lat  Lon
ARG     Argentina   41          -64 -34
AUS     Australia   224         133 -27
CAN     Canada      426         -95 60
IRL     Ireland 68           -8 53
ITA     Italy             583           12.8333 42.8333
NLD     Netherlands 327          5.75   52.5
NZL     'New Zealand' 26           174    -41
ESP     Spain             325            -4  40
GBR     'United Kingdom'  2849             -2 54
USA     'United States'   3162            -97 38
", header=TRUE)

library(ggplot2)
library(maps)

mdat <- map_data('world')

str(mdat)
ggplot() + 
  geom_polygon(dat=mdat, aes(long, lat, group=group), fill="grey50") +
  geom_point(data=dat, 
             aes(x=Lat, y=Lon, map_id=Country, size=`No.of.Documents`), col="red")


library(rworldmap)
sPDF <- getMap()
class(sPDF)
plot(sPDF)
dF <- sPDF@data
str(df)


dF <- data.frame( country=c("spain"
                            ,
                            "uk")
                  , weather=c("hot", "cold") )
sPDF <-
  joinCountryData2Map( dF
                       ,joinCode = "NAME"
                       ,nameJoinColumn = "country")
mapCountryData(sPDF)




library(WDI)
# http://data.worldbank.org/indicator/
# Improved sanitation facilities (% of popn)
indicator <- "SH.STA.ACSN"
dFsanitation <- WDI( indicator=indicator
                     , start=2005
                     , end=2005 )

library(rworldmap)
sPDFsanitation <-
  joinCountryData2Map( dFsanitation
                       , nameJoinColumn='iso2c'
                       , joinCode='ISO2')
library(RColorBrewer)
numCats <- 100
#colourPalette <- rev(brewer.pal(numCats, "PuBuGn"))
colourPalette <- brewer.pal(5,'RdYlGn')
mapCountryData( sPDFsanitation
                #, nameColumnToPlot=indicator
                , colourPalette=colourPalette
                , numCats=numCats )


#####
par(mai=c(0,0,0.2,0),xaxs="i",yaxs="i")
mapCountryData( sPDFsanitation, nameColumnToPlot="BIODIVERSITY" )



#####
library(rworldmap)
d <- data.frame(
  country=c("Greece", "France", "Germany", "Italy", "Norway"),
  value=c(-2, -1, 0, 1, 2))
n <- joinCountryData2Map(d, joinCode="NAME", nameJoinColumn="country")
mapCountryData(n, nameColumnToPlot="value", mapTitle="World")



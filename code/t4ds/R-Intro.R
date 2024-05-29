a <- c(1,2,3)
a

my_list <- list(a = a, b = 52)
my_list
my_list$a
my_list[['a']]
my_list$b

my_fun <- function(x) {
  ret <- x + 1
  return(ret)
}
my_fun(3)

my_list$f <- my_fun
my_list$f
# Equivalently:
# my_list[['f']] <- my_fun

my_list$f(2.3)
my_fun(2.3)

str(my_list)

?list

list

data.frame

glacier_csv <- 'https://pkgstore.datahub.io/core/glacier-mass-balance/glaciers_csv/data/c04ec0dab848ef8f9b179a2cca11b616/glaciers_csv.csv'

# this data has a header, so we set header=TRUE to keep it out of the rest of our data
glacier_data <- read.csv(file=glacier_csv, header = TRUE)
glacier_data
class(glacier_data)
dim(glacier_data)
# grab the first 5 rows of glacier_data
head(glacier_data, 5)
# row 1, column 1
glacier_data[1,1]

# row 27, column 3
glacier_data[27,3]

# grab rows 2,3,5 and columns 2,3
glacier_data[c(2, 3, 5), c(2, 3)]
# grab rows 4 through 10, and all 3 columns
glacier_data[4:10, 1:3]
# grab only row 2
glacier_data[2,]

# get min cumulative mass balance
min(glacier_data[,2])
# get mean
mean(glacier_data[,2])
summary(glacier_data)

# view cumulative mass balance vs year
plot(x=glacier_data[,1], y=glacier_data[,2])

# here is the work-around that I found easiest:
# Download the file
download.file("https://ftpgeoinfo.msl.mt.gov/Data/Spatial/MSDI/AdministrativeBoundaries/MontanaCounties_shp.zip", destfile = "MontanaCounties.zip")

# Unzip the file
unzip("MontanaCounties.zip")
library(rgdal)
library(sp)
library(sf)

# look into the dsn
counties <- readOGR(dsn="MontanaCounties_shp", layer="County")


# checking the format of our data
class(counties)
dim(counties)

head(counties, 3)
names(counties)
plot(counties)
counties$NAME
counties[1,]
counties[2,]
which(counties$NAME=="CHOUTEAU") 
counties$NAME[which.min(counties$PERIMETER)]
counties$NAME[which.max(counties$PERIMETER)]
gallatin <- counties[which(counties$NAME=="GALLATIN"),]
plot(gallatin)
coords <- gallatin@polygons[[1]]@Polygons[[1]]@coords
plot(coords)
gallatinSample <- spsample(gallatin,n=1000,"random")
plot(gallatinSample,pch=20,cex=.5)
point.in.polygon(460000,150000,coords[,1],coords[,2])
point.in.polygon(1,2,coords[,1],coords[,2])

#bonus
lakeNeighbors <- counties[c(which(counties$NAME=="FLATHEAD"), which(counties$NAME=="MISSOULA"), which(counties$NAME=="SANDERS")), ]
plot(lakeNeighbors)

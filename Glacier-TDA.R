# Load necessary libraries
library(rgdal)
library(sp)

# Download and unzip the glacier data
download.file("https://www.sciencebase.gov/catalog/file/get/58af7532e4b01ccd54f9f5d3?facet=GNPglaciers_1966", destfile = "GNPglaciers_1966.zip")
unzip("GNPglaciers_1966.zip")

# Read in the downloaded .shp file
glaciers1966 <- readOGR(dsn = ".", layer = "GNPglaciers_1966")

# View the first glacier in the dataset
glaciers1966[1,]

first_five <- head(glaciers1966, 5)
first_five
plot(glaciers1966[1,])
plot(glaciers1966)

names(glaciers1966)
glaciers1966[1,]$GLACNAME
randGlac <- spsample(glaciers1966[1,], n=1000,"random")
plot(randGlac)
unifGlac <- spsample(glaciers1966[1,], n=4000, "regular")
plot(unifGlac, pch=20, cex=.25)

rPointOnPerimeter <- function(n, poly) {
  xy <- poly@coords
  dxy <- diff(xy)
  # hypot depends on the pracma library, make sure it's installed
  h <- hypot(dxy[,1], dxy[,2])
  
  e <- sample(nrow(dxy), n,replace=TRUE, prob=h)
  
  u <- runif(n)
  p <- xy[e,] + u * dxy[e,]
  
  p
}
install.packages("pracma")
library(pracma)
poly <- glaciers1966[1,]@polygons[[1]]@Polygons[[1]]
perimeter <- rPointOnPerimeter(2000, poly)
plot(perimeter)
# this sampling is actually not precisely the right thing to use for our data, 
#but it is what we use in the interest of simplicity

dfGlac <- as.data.frame(unifGlac)
distances <- distFct(perimeter, dfGlac)
# normalize each distance in our function
colors <- distances/max(distances)
plot(dfGlac[,1], dfGlac[,2], pch=20, col= rgb(0, 0, colors), cex=1.5)

Diag1966 <- gridDiag(X=dfGlac, FUNvalues = distances, maxdimension = 1, sublevel = TRUE, printProgress = TRUE)
plot(Diag1966[["diagram"]])

# looking at data from 1998, 2005, and 2015

# 1998 data
download.file("https://www.sciencebase.gov/catalog/file/get/58af765ce4b01ccd54f9f5e7?facet=GNPglaciers_1998", destfile = "GNPglaciers_1998.zip")
unzip("GNPglaciers_1998.zip")

# 2005 data
download.file("https://www.sciencebase.gov/catalog/file/get/58af76bce4b01ccd54f9f5ea?facet=GNPglaciers_2005", destfile = "GNPglaciers_2005.zip")
unzip("GNPglaciers_2005.zip")

# 2015 data
download.file("https://www.sciencebase.gov/catalog/file/get/58af7988e4b01ccd54f9f608?facet=GNPglaciers_2015", destfile = "GNPglaciers_2015.zip")
unzip("GNPglaciers2015.zip")

# reading in the data
glaciers1998 <- readOGR(dsn = ".", layer = "GNPglaciers_1998")
glaciers2005 <- readOGR(dsn = ".", layer = "GNPglaciers_2005")
glaciers2015 <- readOGR(dsn = ".", layer = "GNPglaciers_2015")

# Step 1) creating a grid and points on boundary
unifGlac1998 <- spsample(glaciers1998[1,], n=4000, "regular")
unifGlac2005 <- spsample(glaciers2005[1,], n=4000, "regular")
unifGlac2015 <- spsample(glaciers2015[1,], n=4000, "regular")

perimeter1998 <- rPointOnPerimeter(2000, glaciers1998[1,]@polygons[[1]]@Polygons[[1]])
perimeter2005 <- rPointOnPerimeter(2000, glaciers2005[1,]@polygons[[1]]@Polygons[[1]])
perimeter2015 <- rPointOnPerimeter(2000, glaciers2015[1,]@polygons[[1]]@Polygons[[1]])

# Step 2) computing a Distance function on each grid
distances1998 <- distFct(perimeter1998, as.data.frame(unifGlac1998))
distances2005 <- distFct(perimeter2005, as.data.frame(unifGlac2005))
distances2015 <- distFct(perimeter2015, as.data.frame(unifGlac2015))

# Step 3) computing a grid Filtration
Diag1998 <- gridDiag(X=as.data.frame(unifGlac1998), FUNvalues = distances1998, maxdimension = 1, sublevel = TRUE, printProgress = TRUE)
Diag2005 <- gridDiag(X=as.data.frame(unifGlac2005), FUNvalues = distances2005, maxdimension = 1, sublevel = TRUE, printProgress = TRUE)
Diag2015 <- gridDiag(X=as.data.frame(unifGlac2015), FUNvalues = distances2015, maxdimension = 1, sublevel = TRUE, printProgress = TRUE)

# plotting the resulting persistence diagrams
plot(Diag1998[["diagram"]])
plot(Diag2005[["diagram"]])
plot(Diag2015[["diagram"]])

# summary of the change in shape of the Agassiz Glacier over time
d1 <- bottleneck(Diag1 = Diag1966$diagram, Diag2 = Diag1998$diagram, dimension = 0)
d2 <- bottleneck(Diag1 = Diag1998$diagram, Diag2 = Diag2005$diagram, dimension = 0)
d3 <- bottleneck(Diag1 = Diag2005$diagram, Diag2 = Diag2015$diagram, dimension = 0)

# plotting the scaled bottleneck distances
plot(x=c(1,2,3), y=c(d1/(1998-1966), d2/(2005-1998), d3/(2015-2005)), ylab="Bottleneck Distance", xlab="Measurement Interval", main="Change in Bottleneck Distance over Time")
# with this plot, we can even add segments for visualization
segments(x0 = 1, y0 = d1/(1998-1966), x1 = 2, y1 = d2/(2005-1998), col = "black") 
segments(x0 = 2, y0 = d2/(2005-1998), x1 = 3,  y1 = d3/(2015-2005), col = "black")

plot(glacier1966, main = "Agassiz Glacier in 1966")
plot(glacier1998, main = "Agassiz Glacier in 1998")


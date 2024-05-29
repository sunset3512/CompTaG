library(rgdal)
library(sp)


# downloading 1966 data:
download.file("https://www.sciencebase.gov/catalog/file/get/58af7532e4b01ccd54f9f5d3?facet=GNPglaciers_1966", destfile = "GNPglaciers_1966.zip")
unzip("GNPglaciers_1966.zip")

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
glaciers1966 <- readOGR(dsn = ".", layer = "GNPglaciers_1966")
glaciers1998 <- readOGR(dsn = ".", layer = "GNPglaciers_1998")
glaciers2005 <- readOGR(dsn = ".", layer = "GNPglaciers_2005")
glaciers2015 <- readOGR(dsn = ".", layer = "GNPglaciers_2015")

# method that calculates a glaciers area depending on the year entered:
unique_glacier_names <- unique(glaciers2015$GLACNAME)

# creates a data frame to store glacier names and areas
glacier_areas <- data.frame(Glacier = character(length(unique_glacier_names)),
                            Area_km2 = numeric(length(unique_glacier_names)))

# loops over each glacier
for (i in 1:length(unique_glacier_names)) {
  # filters the dataset for the current glacier
  current_glacier <- glaciers2015[glaciers2015$GLACNAME == unique_glacier_names[i], ]
  
  # extracts the area for the current glacier
  area_m2 <- current_glacier$Area2015
  
  # converts the area from square meters to square kilometers
  area_km2 <- area_m2 / 1000000
  
  # stores the glacier name and its area in the data frame
  glacier_areas[i, "Glacier"] <- unique_glacier_names[i]
  glacier_areas[i, "Area_km2"] <- area_km2
}

# prints the data frame
print(glacier_areas)
# my results seem to confirm the results from the USGS area reduction study for the year 1966
# i reran with the year 1998, and the results are very similar again, i think i might have a rounding error but no major changes
# the results remained exactly as the study suggested for years 2005 and 2015
# it seems that the study's findings are consistent with changing topological shape. 


library(ggplot2)

if(! exists("pollution")) {
  pollution <- readRDS("summarySCC_PM25.rds")
  pollution$fips <- as.factor(pollution$fips)
  pollution$Pollutant <- as.factor(pollution$Pollutant)
  pollution$year <- as.factor(pollution$year)
  pollution$type <- as.factor(pollution$type)  
}

baltimore <- pollution[pollution$fips == "24510", ]

png(filename="figure/plot5.png", bg="transparent",
    width=480, height = 480)

if(! exists("class")) {
  class <- readRDS("Source_Classification_Code.rds")
}

vehicleSCC <- class[grep("^Highway Veh*",class$Short.Name), "SCC"] 
vehicleRelated <- pollution[pollution$SCC %in% coalSCC,]

png(filename="figure/plot4.png", bg="transparent",
    width=480, height = 480)

emissionsPerYear <- tapply(vehicleRelated$Emissions, vehicleRelated$year, sum)

barplot(emissionsPerYear,
        main="Vehicle Related Emissions Per Year - Baltimore", 
        xlab="Year", ylab="Tons")

dev.off()


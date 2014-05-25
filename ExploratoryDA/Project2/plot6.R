library(ggplot2)

if(! exists("pollution")) {
  pollution <- readRDS("summarySCC_PM25.rds")
  pollution$fips <- as.factor(pollution$fips)
  pollution$Pollutant <- as.factor(pollution$Pollutant)
  pollution$year <- as.factor(pollution$year)
  pollution$type <- as.factor(pollution$type)  
}

if(! exists("class")) {
  class <- readRDS("Source_Classification_Code.rds")
}

baltimore <- pollution[pollution$fips == "24510", ]
LA <- pollution[pollution$fips == "06037", ]

vehicleSCC <- class[grep("^Highway Veh*",class$Short.Name), "SCC"] 
vehicleRelatedBaltimore <- baltimore[baltimore$SCC %in% vehicleSCC,]
vehicleRelatedLA <- LA[LA$SCC %in% vehicleSCC,]

emissionsPerYearBaltimore <- tapply(vehicleRelatedBaltimore$Emissions, vehicleRelatedBaltimore$year, sum)
emissionsPerYearLA <- tapply(vehicleRelatedLA$Emissions, vehicleRelatedLA$year, sum)
emissionsPerYear <- rbind(emissionsPerYearBaltimore, emissionsPerYearLA)
rownames(emissionsPerYear) <- c("Baltimore", "Los Angeles")

png(filename="figure/plot6.png", bg="transparent",
    width=480, height = 480)

colors <- c("darkblue", "red")
barplot(emissionsPerYear,
        main="Vehicle Related Emissions Per Year - Baltimore", 
        xlab="Year", ylab="Tons",
        col=colors)
legend("topright", bty="n",
       legend=rownames(emissionsPerYear), 
       fill=colors)

dev.off()


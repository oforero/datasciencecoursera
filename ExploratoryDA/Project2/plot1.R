
if(! exists("pollution")) {
  pollution <- readRDS("summarySCC_PM25.rds")
  pollution$fips <- as.factor(pollution$fips)
  pollution$Pollutant <- as.factor(pollution$Pollutant)
  pollution$year <- as.factor(pollution$year)
  
}

emissionsPerYear <- tapply(pollution$Emissions, pollution$year, sum)

png(filename="figure/plot1.png", bg="transparent",
    width=480, height = 480)

barplot(emissionsPerYear,
        main="Emissions Per Year", 
        xlab="Year", ylab="Tons")

dev.off()



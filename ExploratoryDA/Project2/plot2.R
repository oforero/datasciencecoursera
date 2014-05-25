
if(! exists("pollution")) {
  pollution <- readRDS("summarySCC_PM25.rds")
  pollution$fips <- as.factor(pollution$fips)
  pollution$Pollutant <- as.factor(pollution$Pollutant)
  pollution$year <- as.factor(pollution$year)
  
}

baltimore <- pollution[pollution$fips == "24510", ]

png(filename="figure/plot2.png", bg="transparent",
    width=480, height = 480)

emissionsPerYear <- tapply(baltimore$Emissions, baltimore$year, sum)

barplot(emissionsPerYear,
        main="Emissions Per Year - Baltimore", 
        xlab="Year", ylab="Tons")

dev.off()



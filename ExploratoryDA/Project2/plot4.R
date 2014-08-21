
if(! exists("pollution")) {
  pollution <- readRDS("summarySCC_PM25.rds")
  pollution$fips <- as.factor(pollution$fips)
  pollution$Pollutant <- as.factor(pollution$Pollutant)
  pollution$year <- as.factor(pollution$year)
}

if(! exists("class")) {
  class <- readRDS("Source_Classification_Code.rds")
}

coalSCC <- class[grep("*[Cc][Oo][Aa][Ll]*",class$Short.Name), "SCC"] 
coalRelated <- pollution[pollution$SCC %in% coalSCC,]

emissionsPerYear <- tapply(coalRelated$Emissions, coalRelated$year, sum)

png(filename="figure/plot4.png", bg="transparent",
    width=480, height = 480)

barplot(emissionsPerYear,
        main="Coal Related Emissions Per Year", 
        xlab="Year", ylab="Tons")

dev.off()



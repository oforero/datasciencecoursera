library(ggplot2)

if(! exists("pollution")) {
  pollution <- readRDS("summarySCC_PM25.rds")
  pollution$fips <- as.factor(pollution$fips)
  pollution$Pollutant <- as.factor(pollution$Pollutant)
  pollution$year <- as.factor(pollution$year)
  pollution$type <- as.factor(pollution$type)  
}

baltimore <- pollution[pollution$fips == "24510", ]


emissionsPerYear <- tapply(baltimore$Emissions, list(baltimore$year, baltimore$type), sum)
emissionsPerYear <- as.data.frame(as.table(emissionsPerYear))
colnames(emissionsPerYear) <- c("year", "type", "Emissions")

png(filename="figure/plot3.png", bg="transparent",
    width=480, height = 480)

ggplot(emissionsPerYear, 
       aes(x = year, y = Emissions, fill=year)) + 
  facet_grid(~ type) + 
  geom_bar(stat = "identity")

dev.off()


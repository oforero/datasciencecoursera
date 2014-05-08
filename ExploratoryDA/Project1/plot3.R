source("figures.R")

if(is.null(power)) {
  power <- read.csv("household_power_consumption.txt", sep=";",  
                    na.strings=("?"),
                    colClasses= c("character", "character", "numeric",
                                  "numeric", "numeric", "numeric",
                                  "numeric", "numeric", "numeric"))
  
  power <- subset(power, power$Date == "1/2/2007" | power$Date == "2/2/2007")
}

png(filename="figure/plot3.png", bg="transparent",
    width=480, height = 480)

figureSubMetering(power)

dev.off()

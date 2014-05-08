source("figures.R")

if(is.null(power)) {
  power <- read.csv("household_power_consumption.txt", sep=";",  
                    na.strings=("?"),
                    colClasses= c("character", "character", "numeric",
                                  "numeric", "numeric", "numeric",
                                  "numeric", "numeric", "numeric"))
  
  power <- subset(power, power$Date == "1/2/2007" | power$Date == "2/2/2007")
}

png(filename="figure/plot4.png", bg="transparent",
    width=480, height = 480)

par(mfrow=c(2,2))
figureGlobalActivePower(power)
figureVoltage(power)
figureSubMetering(power)
figureGlobalReactivePower(power)

dev.off()
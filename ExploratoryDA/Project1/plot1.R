
if(is.null(power)) {
  power <- read.csv("household_power_consumption.txt", sep=";",  
                    na.strings=("?"),
                    colClasses= c("character", "character", "numeric",
                                  "numeric", "numeric", "numeric",
                                  "numeric", "numeric", "numeric"))
  
  power <- subset(power, power$Date == "1/2/2007" | power$Date == "2/2/2007")
}

png(filename="figure/plot1.png", bg="transparent",
    width=480, height = 480)

with(power,
     hist(Global_active_power, col="red", 
          breaks=seq(0, 12, by=0.5), 
          xlim=c(0, 8), ylim=c(0,1200), xaxt='n',
          main="Global Active Power", 
          xlab="Global Active Power (kilowatts)", ylab="Frequency"))

axis(side=1, at=seq(0,6, 2), labels=seq(0, 6, 2))

dev.off()



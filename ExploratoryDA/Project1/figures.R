
figureGlobalActivePower <- function (power) {
  with(power,
       plot(seq(1,2880,1), Global_active_power, type="l", 
            #breaks=seq(0, 12, by=0.5), 
            xaxt='n', 
            main=NULL,
            ylab="Global Active Power (kilowatts)", xlab=""))
  
  axis(side=1, at=seq(0,2880, 1440), labels=c("Thu", "Fri", "Sat"))
}

figureVoltage <- function (power) {
  with(power,
       plot(seq(1,2880,1), Voltage, type="l", 
            #breaks=seq(0, 12, by=0.5), 
            xaxt='n', 
            main=NULL,
            ylab="Voltage", xlab="datetime"))
  
  axis(side=1, at=seq(0,2880, 1440), labels=c("Thu", "Fri", "Sat"))
}

figureGlobalReactivePower <- function (power) {
  with(power,
       plot(seq(1,2880,1), Global_reactive_power, type="l", 
            #breaks=seq(0, 12, by=0.5), 
            xaxt='n', 
            main=NULL,
            ylab="Global_reactive_power", xlab="datetime"))
  
  axis(side=1, at=seq(0,2880, 1440), labels=c("Thu", "Fri", "Sat"))
}

figureSubMetering <- function (power) {
  with(power,
       plot(seq(1,2880,1), Sub_metering_1, type="l", 
            col="black", 
            ylim=c(0,40), xaxt='n', yaxt='n', 
            main=NULL,
            ylab="", xlab=""))
  par(new=T)
  
  with(power,
       plot(seq(1,2880,1), Sub_metering_2, type="l", 
            col="red", 
            ylim=c(0,40), xaxt='n', yaxt='n', 
            main=NULL,
            ylab="", xlab=""))
  par(new=T)
  with(power,
       plot(seq(1,2880,1), Sub_metering_3, type="l", 
            col="blue", 
            ylim=c(0,40), xaxt='n', yaxt='n', 
            main=NULL,
            ylab="", xlab=""))
  
  title(ylab="Energy sub metering")
  axis(side=1, at=seq(0,2880, 1440), labels=c("Thu", "Fri", "Sat"))
  axis(side=2, at=seq(0,30, 10), labels=seq(0,30, 10))
  legend('topright', lty=1, 
         col=c('black', 'red', 'blue'),
         legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
}
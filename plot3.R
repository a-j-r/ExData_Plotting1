rm(list = ls())
if (!file.exists("hpc.rds")) {
  household_power_consumption <- read.csv("household_power_consumption.txt",sep=";", quote = "\"", header=TRUE, colClasses=c("character", "character", rep("numeric",7)), na.strings=c("?") )
  household_power_consumption[[1]] <- as.Date(household_power_consumption[[1]], "%d/%m/%Y")
  
  household_power_consumption <- household_power_consumption[household_power_consumption$Date >= as.Date("2007-02-01", "%Y-%m-%d") & household_power_consumption$Date <= as.Date("2007-02-02", "%Y-%m-%d"),]
  household_power_consumption[[2]] <- strptime(paste(household_power_consumption[[1]], household_power_consumption[[2]]), "%Y-%m-%d %H:%M:%S", tz="")
  
  saveRDS(household_power_consumption, file = "hpc.rds")
  rm(list = ls())
}
Sys.setlocale("LC_TIME", "English")
hpc <- readRDS("hpc.rds")

png("plot3.png", width=480, height=480)
plot(hpc$Time, hpc$Sub_metering_1, type="l", xlab="", ylab="Energy sub metering")
lines(hpc$Time,hpc$Sub_metering_2, col="red")
lines(hpc$Time,hpc$Sub_metering_3, col="blue")
legend("topright", c(names(hpc)[7:9]), col=c("black", "red", "blue"), lty=1)

dev.off()

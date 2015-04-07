# clean unnecessary data
rm(list = ls())

# read and clean data if necessary (no cleand hpc.rds-file exists)
if (!file.exists("hpc.rds")) {
  household_power_consumption <- read.csv("household_power_consumption.txt",sep=";", quote = "\"", header=TRUE, colClasses=c("character", "character", rep("numeric",7)), na.strings=c("?") )
  household_power_consumption[[1]] <- as.Date(household_power_consumption[[1]], "%d/%m/%Y")
  
  household_power_consumption <- household_power_consumption[household_power_consumption$Date >= as.Date("2007-02-01", "%Y-%m-%d") & household_power_consumption$Date <= as.Date("2007-02-02", "%Y-%m-%d"),]
  household_power_consumption[[2]] <- strptime(paste(household_power_consumption[[1]], household_power_consumption[[2]]), "%Y-%m-%d %H:%M:%S", tz="")
  
  saveRDS(household_power_consumption, file = "hpc.rds")
  rm(list = ls())
}

# set local to english to display english week days.
Sys.setlocale("LC_TIME", "English")

# load cleaned data.
hpc <- readRDS("hpc.rds")

# plot the data into plot3.png.
png("plot3.png", width=480, height=480)
plot(hpc$Time, hpc$Sub_metering_1, type="l", xlab="", ylab="Energy sub metering")
lines(hpc$Time,hpc$Sub_metering_2, col="red")
lines(hpc$Time,hpc$Sub_metering_3, col="blue")
legend("topright", c(names(hpc)[7:9]), col=c("black", "red", "blue"), lty=1)

dev.off()

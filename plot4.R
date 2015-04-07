# remove unnecessary data (reduces memory needs)
rm(list = ls())


# if no cleaned data exists (in file hpc.rds), clean raw data and store them.
if (!file.exists("hpc.rds")) {
  household_power_consumption <- read.csv("household_power_consumption.txt",sep=";", quote = "\"", header=TRUE, colClasses=c("character", "character", rep("numeric",7)), na.strings=c("?") )
  household_power_consumption[[1]] <- as.Date(household_power_consumption[[1]], "%d/%m/%Y")
  
  household_power_consumption <- household_power_consumption[household_power_consumption$Date >= as.Date("2007-02-01", "%Y-%m-%d") & household_power_consumption$Date <= as.Date("2007-02-02", "%Y-%m-%d"),]
  household_power_consumption[[2]] <- strptime(paste(household_power_consumption[[1]], household_power_consumption[[2]]), "%Y-%m-%d %H:%M:%S", tz="")
  
  saveRDS(household_power_consumption, file = "hpc.rds")
  rm(list = ls())
}

# set local to English in order to display englisch weekdays.
Sys.setlocale("LC_TIME", "English")

# load cleaned data.
hpc <- readRDS("hpc.rds")

# creates the asked plot in file plot4.png
png("plot4.png", width=480, height=480)
par(mfcol=c(2,2))
with(hpc,{
plot(hpc$Time, hpc$Global_active_power, type="l", xlab="", ylab="Global Active Power")

plot(hpc$Time, hpc$Sub_metering_1, type="l", xlab="", ylab="Energy sub metering")
lines(hpc$Time,hpc$Sub_metering_2, col="red")
lines(hpc$Time,hpc$Sub_metering_3, col="blue")
legend("topright", c(names(hpc)[7:9]), col=c("black", "red", "blue"), bty="n", lty=1, border=NULL)

plot(hpc$Time, hpc$Voltage, type="l", ylab="Voltage", xlab="datetime")

plot(Time, Global_reactive_power, type="l", xlab="datetime")
})
dev.off()

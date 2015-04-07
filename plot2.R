# Remove unnecesary data
rm(list = ls())

# Load and clean raw data. Saves the cleaned data in hpc.rds.
if (!file.exists("hpc.rds")) {
  household_power_consumption <- read.csv("household_power_consumption.txt",sep=";", quote = "\"", header=TRUE, colClasses=c("character", "character", rep("numeric",7)), na.strings=c("?") )
  household_power_consumption[[1]] <- as.Date(household_power_consumption[[1]], "%d/%m/%Y")
  
  household_power_consumption <- household_power_consumption[household_power_consumption$Date >= as.Date("2007-02-01", "%Y-%m-%d") & household_power_consumption$Date <= as.Date("2007-02-02", "%Y-%m-%d"),]
  
  household_power_consumption[[2]] <- strptime(paste(household_power_consumption[[1]], household_power_consumption[[2]]), "%Y-%m-%d %H:%M:%S", tz="")
  
  saveRDS(household_power_consumption, file = "hpc.rds")
  rm(list = ls())
}

# used for plot display in english (if host language is different)
Sys.setlocale("LC_TIME", "English")

# read the cleaned data
hpc <- readRDS("hpc.rds")

# create the plot in a png-file.
png("plot2.png", width=480, height=480)
plot(hpc$Time, hpc$Global_active_power, type="l", xlab="", ylab="Global Active Power (kilowatts)")
dev.off()

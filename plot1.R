# Remove eventual unnecessary data
rm(list = ls())

# Read the data
if (!file.exists("hpc.rds")) {
household_power_consumption <- read.csv("household_power_consumption.txt",sep=";", quote = "\"", header=TRUE, colClasses=c("character", "character", rep("numeric",7)), na.strings=c("?") )

# Transform data as needed.
household_power_consumption[[1]] <- as.Date(household_power_consumption[[1]], "%d/%m/%Y")
household_power_consumption <- household_power_consumption[household_power_consumption$Date >= as.Date("2007-02-01", "%Y-%m-%d") & household_power_consumption$Date <= as.Date("2007-02-02", "%Y-%m-%d"),]
household_power_consumption[[2]] <- strptime(paste(household_power_consumption[[1]], household_power_consumption[[2]]), "%Y-%m-%d %H:%M:%S", tz="")

#save modified data and clean memory
saveRDS(household_power_consumption, file = "hpc.rds")
rm(list = ls())
}

# Read cleaned data to display
hpc <- readRDS("hpc.rds")

# Create png-file with the diagram.
png("plot1.png", width=480, height=480)
hist(hpc$Global_active_power, col="red", main="Global Active Power", xlab="Global Active Power (kilowats)")
dev.off()

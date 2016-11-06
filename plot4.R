# Read data file and remove non-complete cases
filename <- "household_power_consumption.txt"
data <- read.table(filename, sep = ";", header=TRUE, na.strings="?")
data <- data[complete.cases(data),]

# Subset data for dates in 1/2/2007 - 2/2/2007
data2 <- data[(data$Date=="1/2/2007"|data$Date=="2/2/2007"),]

# Convert date and time to date/time classes
Full_Date <- strptime(paste(data2$Date, data2$Time), "%d/%m/%Y %H:%M:%S")
Weekday <- as.factor(weekdays(Full_Date))
data2 <- cbind(Full_Date, Weekday, data2[,-c(1:2)])

# Initialize png device
png("plot4.png")

# Initialize partition
par(mfcol=c(2,2), mar=c(5,4,1,1))

# Plot (1,1) - Global Activity Power by Date
with(data2, {
    plot(Full_Date, Global_active_power, xlab="", ylab="Global Active Power", type="n")
    lines(Full_Date, Global_active_power)
})

# Plot (2,1) - Energy sub meterings by Date
with(data2, {
    plot(range(Full_Date), 
         c(min(sapply(data2[,c(7:9)],range)),max(sapply(data2[,c(7:9)],range))), 
         xlab="", 
         ylab="Energy sub metering", 
         type="n")
    lines(Full_Date, Sub_metering_1, col="black")
    lines(Full_Date, Sub_metering_2, col="red")
    lines(Full_Date, Sub_metering_3, col="blue")
    legend("topright", 
           legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
           lwd=1,
           col=c("black", "red", "blue"),
           cex=0.6)
})

# Plot (1,2) - Voltage by Date
with(data2, {
    plot(Full_Date, Voltage, xlab="datetime", ylab="Voltage", type="n")
    lines(Full_Date, Voltage)
})

# Plot (2,2) - Global reactive power by Date
with(data2, {
    plot(Full_Date, Global_reactive_power, xlab="datetime", type="n")
    lines(Full_Date, Global_reactive_power)
})

dev.off()




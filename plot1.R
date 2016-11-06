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

# Make a histogram of Global Active Power (kilowatts)
hist(data2$Global_active_power, 
     xlab = "Global Active Power (kilowatts)",
     ylab = "Frequency",
     main = "Global Active Power",
     col = "red")

# Save to png
dev.copy(png, "plot1.png")
dev.off()


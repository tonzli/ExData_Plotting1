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

# Make line plot of Global Active Power by weekdays
with(data2, 
     {
         plot(range(Full_Date), 
              range(Global_active_power), 
              type="n",
              xlab="", 
              ylab="Global Active Power (kilowatts)")
         lines(Full_Date, Global_active_power)
     })

dev.copy(png, "plot2.png")
dev.off()




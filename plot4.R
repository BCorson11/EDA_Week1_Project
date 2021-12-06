setwd('//NLANFS/fldredir/CorsonW/Desktop/Coursera/Ex Data Analysis/Week 1/Project 1')

#Import Data
fulldata <- read.table("household_power_consumption.txt", header = TRUE, 
                       sep = ";", dec = ".")

#To create a date time variable of class time
fulldata$DateTime <- paste(fulldata$Date, fulldata$Time, sep = " ")
fulldata$DateTime <- strptime(fulldata$DateTime, format = "%d/%m/%Y %H:%M:%S")

#To change date variable to class date
fulldata$Date <- as.Date(fulldata$Date, format = "%d/%m/%Y")

#Subset data
mydata <- subset(fulldata, DateTime >= "2007-02-01" & Date <= "2007-02-02", 
                 select = Date:DateTime)

#Change data into numeric
mydata$Global_active_power <- as.numeric(mydata$Global_active_power)
mydata$Global_reactive_power <- as.numeric(mydata$Global_reactive_power)
mydata$Voltage <- as.numeric(mydata$Voltage)
mydata$Global_intensity <- as.numeric(mydata$Global_intensity)
mydata$Sub_metering_1 <- as.numeric(mydata$Sub_metering_1)
mydata$Sub_metering_2 <- as.numeric(mydata$Sub_metering_2)
mydata$Sub_metering_3 <- as.numeric(mydata$Sub_metering_3)

#Open png file
png("plot4.png", width = 480, height = 480)

#Set plot window to 2x2
par(mfrow=c(2,2))

#Build first plot in top left corner of window
with(mydata, plot(DateTime, Global_active_power, type="l", xlab = "",
                  ylab = "Global Active Power"))

#Build second plot in top right corner of window
with(mydata, plot(DateTime, Voltage, xlab = "datetime", ylab = "Voltage", 
     type = "l"))

#Build third plot in bottom left corner of window
with(mydata, plot(DateTime, Sub_metering_1, type = "l", 
                  xlab = "", ylab = "Energy sub metering"))
lines(mydata$DateTime, mydata$Sub_metering_2, type="l", col = "red")
lines(mydata$DateTime, mydata$Sub_metering_3, type="l", col = "blue")
legend("topright", 
       legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),
       col = c("black","red","blue"),
       lty = 1:1)

#Build fourth plot in bottom right coner of window
with(mydata, plot(DateTime, Global_reactive_power, xlab = "datetime",
                  type = "l"))

#Close png file
dev.off()


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
png("plot2.png", width = 480, height = 480)

#Build plot
with(mydata, plot(DateTime, Global_active_power, type="l", xlab = "",
                  ylab = "Global Active Power (kilowatts)"))

#Close png file
dev.off()

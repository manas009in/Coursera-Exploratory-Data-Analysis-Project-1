#Read the table from the dataset into PowerData and SUbset it for the given 2 dates. Ensure that the working directory is set to your desired location.
PowerData <- read.table("./household_power_consumption.txt", header = TRUE, sep = ";", na.strings = "?")
PowerData$Date <- strptime(PowerData$Date, "%d/%m/%Y")
PowerData$Date <- as.Date(PowerData$Date)
SubSetData <- subset(PowerData, subset = (Date >= "2007-02-01" & Date <= "2007-02-02"))


#Remove PowerData DataFile as a Best Practice
rm(PowerData)


#Create and Add a New DateTime Variable to the SubSet Data which will be used for plotting.
datetime <- paste(SubSetData$Date, SubSetData$Time, sep = " ")
datetime <- as.POSIXlt(datetime)
SubSetPlot2$DateTime <- datetime


#Plot the 2x2 Matrix graphs (with legends where required) and copy from the screen (device) to png file. Do not forget to dev.off the device.
par(mfrow = c(2,2), mar=c(4,4,2,1), oma = c(0,0,2,0))

#Graph 1 on top Left
with(SubSetData, plot(DateTime, Global_active_power, type = "l", ylab = "Global Active Power (kilowatts)", xlab = ""))

#Graph 2 on top Right
with(SubSetData, plot(DateTime, Voltage, type = "l", ylab = "Voltage", xlab = "datetime"))

#Graph 3 on Bottom Left
with(SubSetData, plot(DateTime, Sub_metering_1, type = "l", ylab = 
"Energy sub metering", xlab = ""))
with(SubSetData, lines(DateTime, Sub_metering_2, type = "l", col = "Red"))
with(SubSetData, lines(DateTime, Sub_metering_3, type = "l", col = "Blue"))
with(SubSetData, legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty = 1, lwd = 2.5, col = c("black", "Red", "Blue"), cex = 0.75))

#Graph 4 on Bottom Right
with(SubSetData, plot(DateTime, Global_reactive_power, type = "l", ylab = "Global_reactive_power", xlab = "datetime"))

dev.copy(png, file = "plot4.png", height=480, width=480)
dev.off()

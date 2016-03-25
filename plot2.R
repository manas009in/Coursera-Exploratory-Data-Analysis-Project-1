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


#Plot the line graph and copy from the screen (device) to png file. Do not forget to dev.off the device.
plot(SubSetPlot2$DateTime, SubSetPlot2$Global_active_power, type = "l", ylab = "Global Active Power (kilowatts)", xlab = "")
dev.copy(png, file = "plot2.png", height=480, width=480)
dev.off()

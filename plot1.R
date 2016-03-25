#Read the table from the dataset into PowerData and SUbset it for the given 2 dates. Ensure that the working directory is set to your desired location.

PowerData <- read.table("./household_power_consumption.txt", header = TRUE, sep = ";", na.strings = "?")
PowerData$Date <- strptime(PowerData$Date, "%d/%m/%Y")
PowerData$Date <- as.Date(PowerData$Date)
SubSetData <- subset(PowerData, subset = (Date >= "2007-02-01" & Date <= "2007-02-02"))

#Remove PowerData DataFile as a Best Practice
rm(PowerData)

#Plot the histogram and copy from the screen (device) to png file. Do not forget to dev.off the device.
hist(SubSetData$Global_active_power, main = "Global Active Power", xlab = "Global Active Power (kilowatts)", ylab = "Frequency", col = "Red")
dev.copy(png, file = "plot1.png", height = 480, width=480)
dev.off()

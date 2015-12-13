# plot4.R created 12.12.2015
# creates and saves plot1.png plot based on data
# in household_power_consumption.txt

# household_power_consumption.txt inspection shows rows are sorted according
# to date and time. Running unix grep command tells you how many lines to skip
# (skip=66637) to start at 2007-02-01 then read 2x1440 rows until
# 2007-02-02 23:59:00 (nrow=2880).

data <- read.table("household_power_consumption.txt",sep=";",skip=66637,nrow=2880,col.names = colnames(read.table("household_power_consumption.txt", sep=";",nrow = 1, header = TRUE)),na.strings = "?")

# convert Data column into date format and create new column
# with Date+Time formatted with strptime

data$Date <- as.Date(data$Date, "%d/%m/%Y")
data[,"newdate"] <- paste(data$Date,data$Time)
data$newdate <- strptime(data$newdate,"%Y-%m-%d %H:%M:%S")

# Create 4 plots as function of date in same frame and save as plot4.png in
# 480x480 pixel size. Use png() function to save to preserve some aspect ratios.

png(file="plot4.png",width = 480, height = 480, units = "px",bg = "white")
# create frame to hold for plots with some margin specs.
par(mfrow=c(2,2),mar = c(4, 4, 4,4), oma = c(1, 1, 0, 0))

# create 4 different plots

with(data, {
	plot(data$newdate,data$Global_active_power,ylab="Global Active Power",xlab="",type="l")
  plot(data$newdate,data$Voltage,ylab="Voltage",xlab="datetime",type="l")
  plot(data$newdate,data$Sub_metering_1,col="black",ylab="Energy sub metering",xlab="",type="l")
  lines(data$newdate,data$Sub_metering_2,col="red")
  lines(data$newdate,data$Sub_metering_3,col="blue")
	legend("topright", cex=0.7,lty=1,col = c("black", "red","blue"), legend = c("Sub_metering_1", "Sub_metering_2","Sub_metering_3"),box.lwd=0)
	plot(data$newdate,data$Global_reactive_power,ylab="Global_reactive_power",xlab="datetime",type="l")
})
dev.off()

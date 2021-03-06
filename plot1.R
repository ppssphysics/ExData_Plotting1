# plot1.R created 12.12.2015 -- MacOSX 10.10.5
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

# Plot histogram of Global active power and save it as plot1.png in 480x480
# pixel size. Use png() function to save to preserve some aspect ratios.

png(file="plot1.png",width = 480, height = 480, units = "px",bg = "white")
par(mfrow=c(1,1)) # set frame to single plot to overwrite previous settings
hist(data$Global_active_power, main="Global Active Power",xlab="Global Active Power (kilowatts)", ylab="Frequency",xlim=c(0,6), ylim=c(0, 1200),col="red",cex.axis=0.9,xaxp=c(0,6,3),yaxp=c(0,1200,6))
dev.off()

##The assumption is the "household_power_consumption.txt" is in your working directory
##Read in first 100,000 rows - see what dates are in there (seems to have dates of interest)
col <- c(rep("character",2),rep("numeric",7))                  
dat <- read.table("household_power_consumption.txt", sep = ";", header = TRUE, nrows = 100000, colClasses = col, na.strings = "?")              
##Set first Column as Date class
dat[,1] <- as.Date(dat[,1],format="%d/%m/%Y")
##Extract 2 days we want 1st and 2nd of Feb 2007
dat <- subset(dat,Date == "2007-02-01" | Date == "2007-02-02")
##Create datetime vector for plotting (x axis)
dat[,2]<-as.POSIXct(paste(dat$Date,dat$Time))

##Set format and order of plots column 1 first, etc.
par(mfcol = c(2,2), mar = c(4,4,4,2))

##PLOT 1
plot(dat$Global_active_power~dat$Time, data = dat, type = "l", xlab = "",ylab = "Global Active Power")

##PLOT 2
##with(dat, plot(dat$Global_active_power~dat$Time, data = dat, ylab = "Energy sub metering", type = "n"))
with(dat,plot(Time, Sub_metering_1, type = "l", xlab = "",ylab = "Energy sub metering", col = "black"))
with(dat, lines(Time, Sub_metering_2, col = "red"))
with(dat, lines(Time, Sub_metering_3, col = "blue"))
legend("topright", lty = 1, col = c("black","red", "blue"), legend = c(names(dat)[7:9]))

##PLOT 3
plot(dat$Voltage~dat$Time, data = dat, type = "l", xlab = "datetime",ylab = "Voltage")

##PLOT 4
plot(dat$Global_reactive_power~dat$Time, data = dat, type = "l", xlab = "datetime",ylab = "Global_reactive_power")

##Print to File plot4.png
dev.copy(png, file = "plot4.png")
dev.off()

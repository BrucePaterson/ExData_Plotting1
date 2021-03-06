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

##PLOT 2
plot(dat$Global_active_power~dat$Time, data = dat, type = "l", xlab = "",ylab = "Global Active Power (kilowatts)")
dev.copy(png, file = "plot2.png")
dev.off()
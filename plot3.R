# setwd("") *** set the working directory to your data repository
t1 <- read.table("household_power_consumption.txt", header=TRUE, 
                 sep=";", stringsAsFactors=FALSE)
t1$Date <- as.Date(t1$Date, format("%d/%m/%Y")) # Dates
t2 <- subset(t1, t1$Date == "2007-02-01")
t2b <- subset(t1, t1$Date == "2007-02-02")
rm("t1")
t2 <- rbind(t2, t2b)
rm("t2b")
t2$OnlySeconds <- ((as.numeric(as.factor(t2$Time)) - 1) / (24 * 60))
t2$Minutes <- t2$Date + t2$OnlySeconds
#t2$Global_active_power <- as.numeric(t2$Global_active_power)
#t2$Global_reactive_power <- as.numeric(t2$Global_reactive_power)
#t2$Voltage <- as.numeric(t2$Voltage)
t2$Global_intensity <- as.numeric(t2$Global_intensity)
t2$Sub_metering_1 <- as.numeric(t2$Sub_metering_1)
t2$Sub_metering_2 <- as.numeric(t2$Sub_metering_2)
t2$Sub_metering_3 <- as.numeric(t2$Sub_metering_3)
Sys.setlocale("LC_TIME","us")
png(file="plot3.png", width=480, height=480)
plot(t2$Minutes, t2$Sub_metering_1, type="n",
     xlab="", ylab="Energy sub metering")
lines(t2$Minutes, t2$Sub_metering_1, col="darkgrey")
lines(t2$Minutes, t2$Sub_metering_2, col="red")
lines(t2$Minutes, t2$Sub_metering_3, col="blue")
legend("topright", lwd = 1, col=c("darkgrey", "red", "blue"),
       legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))
dev.off()

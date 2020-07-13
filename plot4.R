# Reading, naming and subsetting data
url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
temp <- tempfile()
download.file(url,temp)
data <- read.table(unz(temp, "household_power_consumption.txt"), skip=1,sep=";")
unlink(temp)

names(data) <- c("Date","Time","Global_active_power","Global_reactive_power","Voltage","Global_intensity","Sub_metering_1","Sub_metering_2","Sub_metering_3")

# Subset
usedata <- subset(data,data$Date=="1/2/2007" | data$Date =="2/2/2007")

# Transforming dates
usedata$Date <- as.Date(usedata$Date, format="%d/%m/%Y")
usedata$Time <- strptime(usedata$Time, format="%H:%M:%S")

usedata[1:1440,"Time"] <- format(usedata[1:1440,"Time"],"2007-02-01 %H:%M:%S")
usedata[1441:2880,"Time"] <- format(usedata[1441:2880,"Time"],"2007-02-02 %H:%M:%S")

#plot

par(mfrow =c(2,2))

with(usedata,{
  plot(usedata$Time,as.numeric(as.character(usedata$Global_active_power)),type="l",  xlab="",ylab="Global Active Power")  
  plot(usedata$Time,as.numeric(as.character(usedata$Voltage)), type="l",xlab="datetime",ylab="Voltage")
  plot(usedata$Time,usedata$Sub_metering_1,type="n",xlab="",ylab="Energy sub metering")
  with(usedata,lines(Time,as.numeric(as.character(Sub_metering_1))))
  with(usedata,lines(Time,as.numeric(as.character(Sub_metering_2)),col="red"))
  with(usedata,lines(Time,as.numeric(as.character(Sub_metering_3)),col="blue"))
  legend("topright", lty=1, lwd= 2, col=c("black","red","blue"),legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), cex = 0.6)
  plot(usedata$Time,as.numeric(as.character(usedata$Global_reactive_power)),type="l",xlab="datetime",ylab="Global_reactive_power")
})

# Copy to png
dev.copy(png, file = "plot4.png")
dev.off()

# Reading, naming and subsetting data
url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
temp <- tempfile()
download.file(url,temp)
data <- read.table(unz(temp, "household_power_consumption.txt"), skip=1,sep=";")
unlink(temp)

names(data) <- c("Date","Time","Global_active_power","Global_reactive_power","Voltage","Global_intensity","Sub_metering_1","Sub_metering_2","Sub_metering_3")

# Subset
usedata <- subset(data,data$Date=="1/2/2007" | data$Date =="2/2/2007")

# Plot
hist(as.numeric(usedata$Global_active_power),col="red",main="Global Active Power",xlab="Global Active Power(kilowatts)")

# Copy to png
dev.copy(png, file = "plot1.png")
dev.off()
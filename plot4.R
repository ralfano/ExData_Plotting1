#README:
# * download the script and data and put them in the same folder 
# * set the proper file name in the dataset_file variable
# * set the folder as working directory
# * run the script with the following command source("plot4.R")

library(sqldf)

dataset_file <- "household_power_consumption.csv"

he_subset <- read.csv.sql(
        dataset_file, 
        "select * from file where Date in ('1/2/2007','2/2/2007')",
        header = TRUE, sep = ";")

he_subset [,'Date_d'] <- as.POSIXct(strptime(paste(he_subset$Date,he_subset$Time),"%d/%m/%Y %H:%M:%S"))

png('plot4.png', width=480, height=480)

par(mfrow=c(2,2))

with(he_subset,plot(Date_d,Global_active_power,  type="l", ylab="Global Active Power (Kilowatts)", xlab=""))

with(he_subset,plot(Date_d,Voltage,  type="l", ylab="Voltage", xlab="datetime"))

with (he_subset, plot(Date_d,Sub_metering_1,  type="l", ylab="Energie sub metering", xlab=""))
with (he_subset, lines(Date_d,Sub_metering_2,col="red"))
with (he_subset, lines(Date_d,Sub_metering_3,col="blue"))

legend("topright", lwd=1, col = c("black", "blue", "red"), legend = c("Sub_metering_1", "Sub_metering_2","Sub_metering_3"))

with(he_subset,plot(Date_d,Global_reactive_power,  type="l", ylab="Global Reactive Power", xlab="datetime"))

dev.off()


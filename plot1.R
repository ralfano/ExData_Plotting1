#README:
# * download the script and data and put them in the same folder 
# * set the proper file name in the dataset_file variable
# * set the folder as working directory
# * run the script with the following command source("plot1.R")

library(sqldf)

dataset_file <- "household_power_consumption.csv"

he_subset <- read.csv.sql(
        dataset_file, 
        "select * from file where Date in ('1/2/2007','2/2/2007')",
        header = TRUE, sep = ";")

he_subset [,'Date_d'] <- as.POSIXct(strptime(paste(he_subset$Date,he_subset$Time),"%d/%m/%Y %H:%M:%S"))

png('plot1.png', width=480, height=480)

with(he_subset, hist(Global_active_power, col="red", main="Global Active Power", xlab="Global Active Power (Kilowatts)"))

dev.off()


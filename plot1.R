# From the data available here : 
# https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip

# Subset the dataset to keep only data from the dates 2007-02-01 and 2007-02-02
# Construct a plot (hist) witch present the global active power (kilowatts) by frequency

plot1 <- function(workingDirectory) {
        
        # Set the working directory passed in parameter
        # In my case : 
        # "C:/PROJECTS/Data Science - Coursera/R working directory/Cours 4 - Explorary Data Analysis/Semaine 1/Evaluation"
        setwd(workingDirectory)
        
        # Charge the library dplyr
        library(dplyr)
        
        # Read the file
        household <- read.csv("./household_power_consumption.txt",sep=";",header=TRUE)
        
        # Subset data from the dates 2007-02-01 and 2007-02-02
        myHousehold1 <- subset(household,Date=="1/2/2007")
        myHousehold2 <- subset(household,Date=="2/2/2007")
        myHousehold <- rbind(myHousehold1,myHousehold2)
        
        # Construct the hist plot
        hist(as.numeric(myHousehold$Global_active_power)/500,col="red",main="Global Active Power",xlab="Global Active Power (kilowatts)")
        
        # Export to PNG file
        dev.copy(png,file="plot1.png",width=480,height=480)
        dev.off()
}
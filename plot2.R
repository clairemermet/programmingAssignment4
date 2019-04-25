# From the data available here : 
# https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip

# Subset the dataset to keep only data from the dates 2007-02-01 and 2007-02-02
# Construct a plot witch present the evolution of global active power (kilowatts) 
# by datetime

plot2 <- function(workingDirectory) {
        
        # Set the working directory passed in parameter
        # In my case : 
        # "C:/PROJECTS/Data Science - Coursera/R working directory/Cours 4 - Explorary Data Analysis/Semaine 1/Evaluation"
        setwd(workingDirectory)
        
        # Charge the library dplyr and crayon
        library(dplyr)
        library(crayon)
        
        # Read the file
        household <- read.csv("./household_power_consumption.txt",sep=";",header=TRUE)
        
        # Subset data from the dates 2007-02-01 and 2007-02-02
        myHousehold1 <- subset(household,Date=="1/2/2007")
        myHousehold2 <- subset(household,Date=="2/2/2007")
        myHousehold <- rbind(myHousehold1,myHousehold2)
        
        # Add a column in the datetime format
        dateCol <- strptime(as.character(myHousehold$Date) %+% " " %+% as.character(myHousehold$Time),"%d/%m/%Y %H:%M:%S")
        myHousehold3 <- cbind(dateCol,myHousehold)
        
        # Construct the plot
        plot(myHousehold3$dateCol,as.numeric(myHousehold3$Global_active_power)/500,type="l",ylab="Global Active Power (kilowatts)",xlab="")
        
        # Export to PNG file
        dev.copy(png,file="plot2.png",width=480,height=480)
        dev.off()
}
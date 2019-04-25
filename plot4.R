# From the data available here : 
# https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip

# Subset the dataset to keep only data from the dates 2007-02-01 and 2007-02-02
# Construct 4 plots in a matrix:
# 1: a plot witch present the evolution of global active power (kilowatts) by datetime
# 2: a plot witch present the evolution of voltage by datetime
# 3: a plot witch present the evolution of energy sub metering by sub metering (1,2 and 3)
# 4: a plot witch present the evolution of global reactive power by datetime


plot4 <- function(workingDirectory) {
        
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
        
        # Declare the matrix of plots
        par(mfrow=c(2,2))
        
        # PLOT 1
        plot(myHousehold3$dateCol,as.numeric(myHousehold3$Global_active_power)/500,type="l",ylab="Global Active Power (kilowatts)",xlab="")
        
        # PLOT 2
        plot(myHousehold3$dateCol,myHousehold3$Voltage,type="l",ylab="Voltage",xlab="datetime")
        
        # PLOT 3
        # Construct the plot without y axis
        {
        plot(myHousehold3$dateCol,as.numeric(myHousehold3$Sub_metering_1),type="l",xlab="",ylab="Energy sub metering",lab=c(3,4,0))
        lines(myHousehold3$dateCol,as.numeric(myHousehold3$Sub_metering_2)/4,type="l",col="red")
        lines(myHousehold3$dateCol,as.numeric(myHousehold3$Sub_metering_3),type="l",col="blue")
        # Add great y axis
        axis(side = 2, at = seq(0,30,by=10))
        # Add the legend
        legend("topright",c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),lty=1,col=c("black","red","blue"))
        }
        
        # PLOT 4
        plot(myHousehold3$dateCol,as.numeric(myHousehold3$Global_reactive_power)/500,type="l",ylab="Global_reactive_power",xlab="datetime")
        
        # Export to PNG file
        dev.copy(png,file="plot4.png",width=480,height=480)
        dev.off()
}
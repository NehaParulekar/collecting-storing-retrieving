# Assignment 3 A

# get the path for the working directory
getwd()
#set the working directory by assigning the path for the file
setwd("C:/Users/Neha/Desktop")
# Installing the package "lubridate" 
install.packages("lubridate")
library(lubridate)
#load the file 
Acquisition<-read.csv("Acquisitions.csv", header = TRUE,  sep = ",", quote = "\"")

# Problem 2

# creating the function leastInvInterval
leastInvInterval<-function(leastInvInterval){
# to set the format for the dates
  dates<-as.Date(Acquisition$Date, format="%m/%d/%Y")
# calculating intervals between the dates
Compare_intervals<-c(diff(dates))
#finding the least intervals
least_duration<-min(Compare_duration, na.rm= F)
# to get and print the smallest duration
cat("The smallest duration is","\"")
print(least_duration)
}
leastInvInterval()




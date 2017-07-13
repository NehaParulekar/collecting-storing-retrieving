
#################################################################################
# FINAL PROJECT SUBMISSION
# Neha Parulekar
################################################################################

# get the working directory
getwd()
# set the working directory according to the file location on your desktop
setwd("C:/Users/Neha/Desktop")

# check fot the package and istall new packages if required 

checkpackage <- function(pkg){
  new.pkg <- pkg[!(pkg %in% installed.packages()[, "Package"])]
  if (length(new.pkg)) 
    install.packages(new.pkg, dependencies = TRUE)
  sapply(pkg, require, character.only = TRUE)
}

packages <- c( "lubridate", "dplyr")
checkpackage(packages)

# load the data into R using the read.csv command.
HospitalDetails <- read.csv("HHCompare.State.csv", header = T, sep = ",")

# convert the data into data frame using as.data.frame Command
df <- as.data.frame(HospitalDetails)

# get the required data from delete the rows that are not required.
df <- df[ -c(11, 13, 15, 17, 19, 21) ] # removing unwanted columns from the data frame 







# Assignment 4B

# TASK 1 

# installing and loading the XML package
install.packages("XML")
library(XML)

# 1)Load the XML document at the URL (http://www.xmldatasets.net/temp/179681356453762.xml) directly into a data frame.
SenatorInfData<-xmlToDataFrame("http://www.xmldatasets.net/temp/179681356453762.xml")

# 2) Write a function that returns the names of the senators for a given state

# definig the Function to get senator names
GetSenatorNames<- function(SenNAme){
# get the required info from the dataframe
  StatesSenator <- SenatorInfData[SenatorInfData$state %in% SenNAme,]
# generate the information 
  Names<- c(StatesSenator)
# Print the required results
  cat("The name of the senators for a given state are")
  cat("\n")
  FirstName<- c(Names$first_name)
  print(FirstName)
  LastName<- c(Names$last_name)
  print(LastName)
}

GetSenatorNames("CO")

# 3) Write a function that returns the phone number for a given senator.

# defining the function getphoNENUmber to obtain data
getphoNENUmber<- function(SenFirst, SenLast){
# obtain the first and last name from the dataset  
  senatENUmber <- SenatorInfData[SenatorInfData$first_name %in% SenFirst & SenatorInfData$last_name %in% SenLast,]
 # extract the required information
  Number <- c(senatENUmber)
 # print the result
  cat("Phone number of a senator is")
  cat("\n")
  SenatorsNumber<- c(Number$phone)
  print(SenatorsNumber)
}
getphoNENUmber("Daniel K.", "Akaka")







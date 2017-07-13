# Problem 1 

# first we get the working directory and load the data into the working directory
getwd()
delay.in.flights<- read.table("AirLineDelays.txt", header = TRUE, sep = ",", quote = "\"")
#giving the column nammes
head(delay.in.flights)


# Problem 2
# first we create the function called TotalNumDelays(Carrier)
TotalNumDelays <- function(Carrier) {
  # then we filter the all data related to carrier 
  Filter.Carrier <- delay.in.flights[delay.in.flights$Carrier %in% Carrier,]
  # now we get all the negetive values and make them 0
  if (nrow(Filter.Carrier) > 0) {
    Filter.Carrier[Filter.Carrier < 0] = 0
    # we create required.data in which we calculate the sum of all the columns from 6 to 14 without the NA values
    required.data <- colSums(Filter.Carrier[6:14] != 0 , na.rm = TRUE)
    # from the required.data we find the sum of the first two columns
    Total.delays <- sum(required.data[1:2])
    # to get different types of arrays 
    cat("The Total Numbers of different types Delays of your Carrier", "\"",Carrier,"\"", "are","\n\n")
    print(required.data)
    cat("\n")
    cat("As all the delays are included in Arrival and departure, we just calculate the sum of these two","\n\n")
    cat("So The total number of delays of a Carrier", "\"",Carrier,"\"" ,"are",Total.delays )
  }
  else {
    print ("CARRIER DOES NOT MATCH")
  }
}
TotalNumDelays("AA")

 
# Problem 3
 
 #First we create a function called TotalNumDelays(ORIGIN)
 TotalDelaysByOrigin <- function(ORIGIN) {
   #to separate data for a particular Origin 
   Filtering.Origin <- delay.in.flights[delay.in.flights$ORIGIN %in% ORIGIN,]
   if (nrow(Filtering.Origin) > 0) {
     # now we make all the negative values to zero
     Filtering.Origin[Filtering.Origin < 0] = 0
     Element <- colSums(Filtering.Origin[6:14] != 0 , na.rm = TRUE)
     #to count elements of column
     Total <- sum(Element[1])
     #to get different types of delays from your Origin
     cat("The Total Numbers of  Delays from your Origin from different types", "\"",ORIGIN,"\"", "are","\n\n")
     print(Element)
     cat("\n")
     cat("The total number of delays are sum of Departure Delay  as we need the delays from a particular origin so , ","\n\n")
     #to get the total number of delays
     cat("The total number of delays from the Origin", "\"",ORIGIN,"\"" ,"are", Total)
   }
   else {
     print ("ORIGIN DOES NOT MATCH")
   }
 }
 TotalDelaysByOrigin("JFK")

# Problem 4 
#check if delays.in.flights exists
if (!exists("delay.in.flights")) {
  delay.in.flights <- read.table("AirLineDelays.txt", header = T, sep = ",")
}
# First create function called AvgDelay(Carrier,Dest) 
AvgDelay <- function (Carrier,Dest) {
  #create a data.frame with columns for CARRIER, ARR_DELAY and DEST
  delay <- data.frame(delay.in.flights$CARRIER,delay.in.flights$ARR_DELAY, delay.in.flights$DEST)
  #remove all the NA values 
  delay.omit.na<- na.omit(delay)
  #Create a Subset that reads data from DEST and CARRIER
  delay.in.flights <- subset(delay.omit.na, delay.in.flights.ARR_DELAY>0 & delay.in.flights.DEST==Dest & delay.in.flights.CARRIER==Carrier)
  #calculate average arrival delay for a carrier flying into the specified destination airport.
  result <- mean(delay.in.flights$delay.in.flights.ARR_DELAY)
  #returns the result
  return(result)
}
#gives Avg delays of the Destination Airport code and Carrier Code
AvgDelay ('AA','DFW')


# Problem 5 
# No need to rerun the Program
TotalNumDelays("AA")
TotalDelaysByOrigin("JFK")
AvgDelay ('AA','DFW')



 
 
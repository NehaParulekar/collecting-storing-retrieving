# Assignment 4 C

rm(list = ls())

# installing and loading the XML package
install.packages("XML")
library(XML)

# Task 1 
# Load and then parse the XML document at the URL
# Create any intermediate data objects as deemed necessary
# how many auctions had more than 5 bids

# parsing the XML document
biddinGINfourl<-xmlInternalTreeParse("http://www.cs.washington.edu/research/xmldatasets/data/auctions/ebay.xml")
# to get all the auction info and filter the auction with more than five bids
numbeRINfo<-xpathApply(biddinGINfourl,"//listing/auction_info[num_bids>5]/num_bids", function(n) as.numeric(xmlValue(n)))
# print the number of bids 
bids<-length(numbeRINfo)
cat("the number of auctions with more than five bids")
print(bids)


# TASK 2

# 2a) what was the highest closing price for the security?

# load the data and convert it into Data Frame for all the solutions below
TradeDataUrl <-"http://www.barchartmarketdata.com/data-samples/getHistory15.xml"
TradeData <-xmlToDataFrame(TradeDataUrl)

# funtion to get highest closing price for security
HighestClosingPrice<- function(Price){
 # get the column for highest closing and print 
  MaxPrice<-max(TradeData$high, na.rm = T)
  cat("highest closing price for the security")
  cat("\n")
  print(MaxPrice)
}

HighestClosingPrice(ClosingPrice)

# 2b)what was the total volume traded?

# load the data and convert it into a dataframe
# write a function to get the total volume 
VolumeTraded <- function(volume){
  # convert the class as numeric and get the volume column and find the sum 
  TotalVolume <- sum(as.numeric(TradeData$volume), na.rm = T)
  # print the sum of the the total volume
  cat(" the total volume traded")
  cat("\n")
  print(TotalVolume)
}
VolumeTraded(VolumeTraded)

# 2c)what was the average trading volume during each HOUR of the trading day; place the result into a data frame

# to extract the volume from the data frame 
HourAvg<-as.numeric(as.character(TradeData$volume))
# removing the status
HourAvg<-HourAvg[-1]
HourAvg<-head(cbind(HourAvg), n= 92)
# splitting the data into equal length
HourAvg <- split(HourAvg, rep(seq(23), length(92), each=(4)))
HourAvg<-as.data.frame(HourAvg)
#finding the average of each column in the data frame 
for(i in 1:23)
{
  Avg = sum(HourAvg[i]/4)
  print(Avg)
}


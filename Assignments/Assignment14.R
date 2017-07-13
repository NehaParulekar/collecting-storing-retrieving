library(mongolite)

rm(list = ls())

# Function to load birdstrike data from working directory.
loadBirdStrikeData <- function(file = "Bird Strikes.csv") {
  # Load Bird strike data from working directory.
  df <- read.csv(file = file, stringsAsFactors = FALSE, header = TRUE)
  titles <- colnames(df) 
  # Change column names and remove '.'
  colnames(df) <- gsub("\\.", "", titles)
  return (df)
}

db = "BirdStrike"
collection = "data"

# question 2
df <- loadBirdStrikeData()
mongoData<- mongo(db = db, collection = collection)
mongoData$insert(df)
mongoData$export(file("data.txt"))


# Question # 3

# 3.A) 
mongoData$distinct(key = "AirportName")

# 3.B) 
mongoData$count(query = '{"OriginState":"New Jersey"}')

# 3.C) 

mongoData$find(query = '{"ConditionsPrecipitation":"Fog"}', 
               sort = '{"RecordID":-1}')


# Question # 4


# Function to get records for given airline and show only given fields.
getRecordsFor <- function(airline, field) {
  query <- sprintf('{"AircraftAirlineOperator":"%s"}', airline)
  # We only need to get given fields and omit _id
  fields <- sprintf('{"%s":1, "_id": 0}', field)
  mongoData$find(query = query, fields = fields)
}

# 4.i) 
getRecordsFor("AMERICAN AIRLINES", "RecordID")
getRecordsFor("CONTINENTAL AIRLINES", "RecordID")

# 4.ii) 
getRecordsFor("AMERICAN AIRLINES", "OriginState")
getRecordsFor("CONTINENTAL AIRLINES", "OriginState")

# 4.iii)
getRecordsFor("AMERICAN AIRLINES", "AircraftAirlineOperator")
getRecordsFor("CONTINENTAL AIRLINES", "AircraftAirlineOperator")

# 4.iv) 
getRecordsFor("AMERICAN AIRLINES", "AirportName")
getRecordsFor("CONTINENTAL AIRLINES", "AirportName")

##### Project on health care ##### 

rm(list = ls())

library(mongolite)

# Load data into mongoDB
loadData <- function (file) {
  df <- read.csv(file = file, header = TRUE, stringsAsFactors = FALSE)
  colnames(df) <- gsub("\\.", "", colnames(df))
  mongoData <- mongo(collection = "data", db = "Health")
  mongoData$insert(df)
  return (mongoData)
}

##### Analysis #####
file <- "HHCompare.State.csv"
mongoData <- loadData(file)

# Get distinct types of ownersips
mongoData$distinct(key = "TypeofOwnership")

# Get count of agencies offering physical therapy services
mongoData$count('{"OffersPhysicalTherapyServices": "Yes"}')

# Get count of agencies offering medical social services
mongoData$count('{"OffersMedicalSocialServices":"Yes"}')

# Get agencies offering occupational therapy service
mongoData$distinct(key = "TypeofOwnership", query = '{"OffersOccupationalTherapyServices":"Yes"}')

# Get distinct provider names
mongoData$distinct(key = "ProviderName")

# Get list of providers in MA
mongoData$distinct(key = "TypeofOwnership", query = '{"State": "MA"}')

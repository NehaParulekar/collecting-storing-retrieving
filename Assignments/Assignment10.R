ipak <- function(pkg){
  new.pkg <- pkg[!(pkg %in% installed.packages()[, "Package"])]
  if (length(new.pkg)) 
    install.packages(new.pkg, dependencies = TRUE)
  sapply(pkg, require, character.only = TRUE)
}


packages <- c("RSQLite", "lubridate")
ipak(packages)

getwd()
setwd("C:/Users/Neha/Desktop")

BirdStrikesData <- read.csv("Bird Strikes.csv", header = T, sep = ",")

db <- dbConnect(SQLite(), dbname="BirdStrikes.sqlite")
dbSendQuery(conn = db,  "PRAGMA foreign_keys = ON")

dbSendQuery(conn = db,  "CREATE TABLE AirCraftFeatures(Aircraft_type TEXT, No_of_Engines INTEGER, Aircraft_Model TEXT, Flight_No INTEGER)")
AircraftFeatures = cbind.data.frame(BirdStrikesData$Aircraft..Type, BirdStrikesData$Aircraft..Number.of.engines, BirdStrikesData$Aircraft..Make.Model, BirdStrikesData$Aircraft..Flight.Number)
dbWriteTable(conn=db, name="AircraftFeatures", AircraftFeatures, append=T, row.names=F)

dbSendQuery(conn = db,  "CREATE TABLE Airport (Airport_Name TEXT, Flight_No INTEGER, Operator INTEGER, Location TEXT)")
Airport = cbind.data.frame(BirdStrikesData$Airport..Name,  BirdStrikesData$Aircraft..Flight.Number, BirdStrikesData$Aircraft..Airline.Operator, BirdStrikesData$Location..Nearby.if.en.route )
dbWriteTable(conn=db, name="Airport", Airport, append=T, row.names=F)


dbSendQuery(conn = db,  "CREATE TABLE FlightParameter (Flight_date TEXT, Time INTEGER, Feet_above_altitude INTEGER, phase_of_flight INTEGER, Flight_No INTEGER, Record_id INTEGER)") 
FlightParameter = cbind.data.frame(BirdStrikesData$FlightDate,  BirdStrikesData$When..Time..HHMM., BirdStrikesData$Feet.above.ground, BirdStrikesData$When..Phase.of.flight, BirdStrikesData$Aircraft..Flight.Number, BirdStrikesData$Record.ID )
dbWriteTable(conn=db, name="FlightParameter", FlightParameter, append=T, row.names=F)


dbSendQuery(conn = db,  "CREATE TABLE Wildlife (Species TEXT, Size INTEGER, Location TEXT)")
Wildlife = cbind.data.frame(BirdStrikesData$Wildlife..Species,  BirdStrikesData$Wildlife..Size, BirdStrikesData$Location..Nearby.if.en.route)
dbWriteTable(conn=db, name="Wildlife", Wildlife, append=T, row.names=F)


dbSendQuery(conn = db,  "CREATE TABLE BirdStrike (Number_struck INTEGER, Size INTEGER, Remains_obtained INTEGER, Record_id INTEGER)") 
BirdStrike = cbind.data.frame(BirdStrikesData$Wildlife..Number.struck,  BirdStrikesData$Wildlife..Size, BirdStrikesData$Remains.of.wildlife.collected., BirdStrikesData$Record.ID )
dbWriteTable(conn=db, name="BirdStrike", BirdStrike, append=T, row.names=F)


dbSendQuery(conn = db,  "CREATE TABLE Effect(Impact_to_flight TEXT, Indicated_Damage, Others TEXT)") 
Effect = cbind.data.frame(BirdStrikesData$Effect..Impact.to.flight,  BirdStrikesData$Effect..Indicated.Damage, BirdStrikesData$Effect..Other)
dbWriteTable(conn=db, name="Effect", Effect , append=T, row.names=F)


dbSendQuery(conn = db,  "CREATE TABLE Condition(Precipitation TEXT, Sky TEXT, Date INTEGER)") 
Condition = cbind.data.frame(BirdStrikesData$Conditions..Precipitation,  BirdStrikesData$Conditions..Sky, BirdStrikesData$FlightDate)
dbWriteTable(conn=db, name="Condition", Condition , append=T, row.names=F)


DataSet<- data.frame(AircraftFeatures, Airport, FlightParameter, BirdStrike, Wildlife, Effect, Condition)
 


Sql_query_q1<- dbGetQuery(conn = db, "SELECT count(Number_Struck) FROM BirdStrike WHERE record_id in (SELECT record_id FROM Airport WHERE Operator = 'AMERICAN AIRLINES') AND Number_Struck != '0'")

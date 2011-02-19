DROP TABLE IF EXISTS stopdescriptions;
CREATE TABLE stopdescriptions (
  latitude float,
  longitude float,
  tsndescription varchar(255),
  tsn integer primary key
);

DROP TABLE IF EXISTS stops;
CREATE TABLE stops (
  tsn integer primary key,
  organisation varchar(255), --Canditate for normalisation
  destination varchar(255),
  vehicleid integer NULL,
  realtime boolean,
  arrivaltime timestamp,
  routename varchar(8)
);
--"organisation","destination","vehicleid","realtime","arrivaltime","routename","tsn"

DROP TABLE IF EXISTS vehicles;
CREATE TABLE vehicles (
  vehicleid integer, --sometimes blank in raw data
  latitude float,
  longitude float,
  tripstatus varchar(255), --Candidate for normalisation
  routedirection int, --Useful in our app?
  routevariant int,   --Useful in our app?
  routename varchar(255), --Candidate for normalisation
  servicedescription varchar(255), --Candidate for normalisation
  organisation varchar(255) --Candidate for normalisation
)

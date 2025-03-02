--Show tables
SELECT distinct table_name FROM user_tables;


select * from location;
show user;
SELECT * from newspaper;

describe newspaper;
set FEEDBACK OFF;

SELECT * from NEWSPAPER WHERE section='F' ORDER by page,FEATURE;

select Feature, Section, Page from NEWSPAPER
 where Section = 'F'
 order by Page desc, Feature;

-- Single Value Test 


  select Feature, Section, Page
 from NEWSPAPER
 where Page = 6;


 select Feature, Section, Page
 from NEWSPAPER
 where Section = 'B';

 select Feature, Section, Page
 from NEWSPAPER
 where Page > 4;

 select Feature, Section, Page
 from NEWSPAPER
 where Section > 'B';

 select Feature, Section, Page
 from NEWSPAPER
 where Page < 8;

 select Feature, Section, Page
 from NEWSPAPER
 where Page <> 1;


-- LIKE

 select Feature, Section, Page from NEWSPAPER
 where Feature LIKE 'Mo%';

 select Feature, Section, Page from NEWSPAPER
 where Feature LIKE '__i%';

 select Feature, Section, Page from NEWSPAPER
 where Feature LIKE '__i%' order by Feature;

  select Feature, Section, Page from NEWSPAPER
 where Feature LIKE '%o%o%';

 select Feature, Section, Page from NEWSPAPER
 where Feature LIKE '%i%i%';


--NULL and NOT NULL 


 select City, SampleDate, Precipitation
 from COMFORT
 where Precipitation IS NULL;

 select City, SampleDate, Precipitation
 from COMFORT
 where Precipitation IS NOT NULL;

 select Feature, Section, Page
 from NEWSPAPER
 where Section IN ('A','B','F');

  select Feature, Section, Page
 from NEWSPAPER
 where Section NOT IN ('A','B','F');

  select Feature, Section, Page
 from NEWSPAPER
 where Page BETWEEN 7 and 10;

 select Feature, Section, Page
 from NEWSPAPER
 where Section = 'F'
 AND Page > 7;

  select Feature, Section, Page
 from NEWSPAPER
 where Section = 'F'
 OR Page > 7;

 select Feature, Section, Page
 from NEWSPAPER
 where Section = 'F'
 and Page BETWEEN 7 AND 10;

-- Combining Logic

 select Feature, Section, Page
 from NEWSPAPER
 where Section = 'A'
 or Section = 'B'
 and Page > 2;

 select Feature, Section, Page
 from NEWSPAPER
 where Page > 2
 and ( Section = 'A' or Section = 'B' );

 -- Another Use for where : Subqueries

 select Section from NEWSPAPER
 where Feature = 'Doctor Is In';

  select FEATURE from NEWSPAPER
 where Section = (select Section from NEWSPAPER
 where Feature = 'Doctor Is In');

  select * from NEWSPAPER
 where Section < (select Section from NEWSPAPER
 where Feature = 'Doctor Is In');

-- Lists of Values from a Subquery

  select City, Country from LOCATION;

  select City from WEATHER
 where Condition = 'CLOUDY';

 select City, Country from LOCATION
 where City IN ('PARIS', 'SPARTA');

  select City, Country from LOCATION
 where City IN (select City from WEATHER
 where Condition = 'CLOUDY');


-- combining table:

 select City, Condition, Temperature from WEATHER;

 select City, Longitude, EastWest, Latitude, NorthSouth
 from LOCATION;

  select WEATHER.City, Condition, Temperature, Latitude,
 NorthSouth, Longitude, EastWest
 from WEATHER, LOCATION
 where WEATHER.City = LOCATION.City;


-- Insert two table into one

 create table com_tab as(
    select WEATHER.city,condition,Temperature,Latitude,NorthSouth,Longitude,EastWest from WEATHER,location where WEATHER.city=location.CITY
    );

select * from com_tab;

 select * from combine;

-- Craeating a view

 create view invasion as select weather.city, condition, temperature, Latitude,NorthSouth,Longitude,EastWest from weather, location where weather.city=location.city;

 describe invasion;

 select City, Condition, Temperature, Latitude, NorthSouth,
 Longitude, EastWest
 from INVASION;

 select City, Condition, Temperature, Latitude, NorthSouth,
 Longitude, EastWest
 from INVASION
 where Country = 'GREECE';

-- ERROR at line 4: ORA-00904: "COUNTRY": invalid identifier...  it was not in the select clause when the view was created

create or replace view INVASION as
 select WEATHER.City, Condition, Temperature, Latitude,
 NorthSouth, Longitude, EastWest
 from WEATHER, LOCATION
 where WEATHER.City = LOCATION.City
 and Country = 'GREECE';

  select City, Condition, Temperature, Latitude, NorthSouth,
 Longitude, EastWest
 from INVASION;


--   Expanding the View

  create or replace view PERU_LOCATIONS as
 select * from LOCATION
 where Country = 'PERU';

 create or replace view RESTRICTED_NAMES as
 select * from NAME
 where Name = User;
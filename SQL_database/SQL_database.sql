-- DROP DATABASE project_5_database
-- CREATE DATABASE project_5_database;

USE project_5_database;

-- DROP TABLE cities;
CREATE TABLE cities (
    city VARCHAR(50),
    country VARCHAR(50),
    latitude FLOAT(6), 
    longitude FLOAT(6), 
    elevation_in_meters INTEGER, 
    elevation VARCHAR(50),
    website VARCHAR(100),
    population INTEGER,
    PRIMARY KEY (city)
);

-- DROP TABLE weather;
CREATE TABLE weather (
	weather_id INTEGER AUTO_INCREMENT,
	city VARCHAR(50),
    country VARCHAR(50),
    latitude FLOAT(6), 
    longitude FLOAT(6), 
	temp FLOAT(3),
    temp_min FLOAT(3),
    temp_max FLOAT(3),
    date_of_forecast DATETIME, 
    weather_overview VARCHAR(50),
    weather_description VARCHAR(150),
    feels_like FLOAT(3),
    pressure INTEGER,
    humidity INTEGER,
    wind_speed FLOAT(3),
    wind_deg FLOAT(3),
    clouds INTEGER,
    PRIMARY KEY (weather_id),
    FOREIGN KEY (city) REFERENCES cities(city)
);

-- DROP TABLE icao_conversion;
CREATE TABLE icao_conversion (
    icao CHAR(4),
    city VARCHAR(50),
    airport_name VARCHAR(50),
    PRIMARY KEY (icao),
    FOREIGN KEY (city) REFERENCES cities(city)
);


-- DROP TABLE flights;
CREATE TABLE flights (
    flight_number VARCHAR(10),
    flight_status VARCHAR(30),
    airline VARCHAR(30),
    cargo VARCHAR(10),
    departure_iata CHAR(3),
    departure_city VARCHAR(30),
    local_departure_time DATETIME, 
    utc_departure_time DATETIME, 
    arrival_icao CHAR(4),
    arrival_terminal INTEGER,
    local_arrival_sceduled_time DATETIME,
    utc_arrival_sceduled_time DATETIME,
    local_arrival_actual_time DATETIME,
    utc_arrival_actual_time DATETIME,
    PRIMARY KEY (flight_number),
    FOREIGN KEY (arrival_icao) REFERENCES icao_conversion(icao)
);



SELECT * FROM weather;
SELECT * FROM flights;
SELECT * FROM cities;
SELECT * FROM icao_conversion;


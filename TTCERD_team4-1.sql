DROP TABLE ContactInformation CASCADE CONSTRAINTS;
DROP TABLE Event CASCADE CONSTRAINTS;
DROP TABLE MaintenanceRecord CASCADE CONSTRAINTS;
DROP TABLE MaintenancePersonnel CASCADE CONSTRAINTS;
DROP TABLE Infraction CASCADE CONSTRAINTS;
DROP TABLE Fare CASCADE CONSTRAINTS;
DROP TABLE Schedule CASCADE CONSTRAINTS;
DROP TABLE Bus CASCADE CONSTRAINTS;
DROP TABLE Site CASCADE CONSTRAINTS;
DROP TABLE Passenger CASCADE CONSTRAINTS;
DROP TABLE BusDriver CASCADE CONSTRAINTS;
DROP TABLE Route CASCADE CONSTRAINTS;
DROP TABLE Stop CASCADE CONSTRAINTS;
DROP TABLE Person CASCADE CONSTRAINTS;

CREATE TABLE Person (
    person_id NUMBER PRIMARY KEY,
    first_name VARCHAR2(100),
    last_name VARCHAR2(100),
    gender VARCHAR2(10),
    date_of_birth DATE,
    street_address VARCHAR2(200),
    city_address VARCHAR2(100),
    province VARCHAR2(100),
    occupation VARCHAR2(100)
);

CREATE TABLE ContactInformation (
    contact_id NUMBER PRIMARY KEY,
    person_id NUMBER,
    contact_type VARCHAR2(50),
    contact_number VARCHAR2(20),
    FOREIGN KEY (person_id) REFERENCES Person(person_id)
);

CREATE TABLE Stop (
    stop_id NUMBER PRIMARY KEY,
    stop_name VARCHAR2(100)
);

CREATE TABLE Site (
    site_id NUMBER PRIMARY KEY,
    stop_id NUMBER,
    site_address VARCHAR2(200),
    site_name VARCHAR2(100),
    phone_number VARCHAR2(20),
    capacity NUMBER,
    category VARCHAR2(50),
    FOREIGN KEY (stop_id) REFERENCES Stop(stop_id)
);

CREATE TABLE Event (
    event_id NUMBER PRIMARY KEY,
    site_id NUMBER,
    event_time TIMESTAMP,
    event_date DATE,
    number_of_participants NUMBER,
    event_name VARCHAR2(100),
    FOREIGN KEY (site_id) REFERENCES Site(site_id)
);

CREATE TABLE MaintenanceRecord (
    mr_id NUMBER PRIMARY KEY,
    maintenance_id NUMBER,
    bus_id NUMBER,
    repair_date DATE
);

CREATE TABLE MaintenancePersonnel (
    maintenance_id NUMBER PRIMARY KEY,
    person_id NUMBER,
    specialization VARCHAR2(100),
    years_of_service NUMBER,
    mp_level VARCHAR2(50),
    salary NUMBER(10, 2),
    FOREIGN KEY (person_id) REFERENCES Person(person_id)
);

CREATE TABLE Passenger (
    passenger_id NUMBER PRIMARY KEY,
    person_id NUMBER,
    passenger_type VARCHAR2(50),
    FOREIGN KEY (person_id) REFERENCES Person(person_id)
);

CREATE TABLE BusDriver (
    driver_id NUMBER PRIMARY KEY,
    person_id NUMBER,
    salary NUMBER(10, 2),
    years_of_service NUMBER,
    incidents_occurred NUMBER,
    FOREIGN KEY (person_id) REFERENCES Person(person_id)
);

CREATE TABLE Route (
    route_id NUMBER PRIMARY KEY,
    route_name VARCHAR2(100)
);

CREATE TABLE Bus (
    bus_id NUMBER PRIMARY KEY,
    route_id NUMBER,
   years_in_operations NUMBER,
   number_of_seats NUMBER,
   manufacturer_name VARCHAR2(100),
   advertising_revenue NUMBER(10, 2),
   fuel_type VARCHAR2(50),
   FOREIGN KEY (route_id) REFERENCES Route(route_id)
);

CREATE TABLE Schedule (
   schedule_id NUMBER PRIMARY KEY,
   route_id NUMBER,
   stop_id NUMBER,
   bus_id NUMBER,
   arrival_time TIMESTAMP,
   arrival_date DATE,
   FOREIGN KEY (route_id) REFERENCES Route(route_id),
   FOREIGN KEY (stop_id) REFERENCES Stop(stop_id),
   FOREIGN KEY (bus_id) REFERENCES Bus(bus_id)
);

CREATE TABLE Fare (
   fare_id NUMBER PRIMARY KEY,
   passenger_id NUMBER,
   amount NUMBER(10, 2),
   fare_type VARCHAR2(50),
   FOREIGN KEY (passenger_id) REFERENCES Passenger(passenger_id)
);

CREATE TABLE Infraction (
   infraction_id NUMBER PRIMARY KEY,
   driver_id NUMBER,
   infraction_type VARCHAR2(100),
   date_of_occurrence DATE,
   demerit_points NUMBER,
   penalty NUMBER(10, 2),
   FOREIGN KEY (driver_id) REFERENCES BusDriver(driver_id)
);
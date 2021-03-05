# Datasets used: AirlineDetails.csv, passengers.csv and senior_citizen.csv
-- -----------------------------------------------------
-- Schema Airlines
create database Airlines;
USE Airlines;

-- -----------------------------------------------------
-- ---------------------------------------------------------------------------------------------------------------------------------------------------
-- 1. Create a table Airline_Details. Follow the instructions given below: 
-- -- Q1. Values in the columns Flight_ID should not be null.
-- -- Q2. Each name of the airline should be unique.
-- -- Q3. No country other than United Kingdom, USA, India, Canada and Singapore should be accepted
-- -- Q4. Assign primary key to Flight_ID
create table Airline_Details(flight_id int not null,
Airline varchar(100) NULL unique,
Country varchar(50) NULL check (Country in ('United Kingdom', 'USA', 'India', 'Canada' , 'Singapore') ),
punctuality float null,
service_quality float null,
airhelp_score float null,
primary key(flight_id));
desc Airline_Details;
select * from Airline_Details;
-- ---------------------------------------------------------------------------------------------------------------------------------------------------

-- 2. Create a table Passengers. Follow the instructions given below: 
-- -- Q1. Values in the columns Traveller_ID and PNR should not be null.
-- -- Q2. Only passengers having age greater than 18 are allowed.
-- -- Q3. Assign primary key to Traveller_ID
create table if not exists Passengers(
Traveller_ID varchar(5) not null,
NAME varchar(50) null,
PNR varchar(10) not null,
flight_id int null,
ticket_price int null,
age int check(age>18),
primary key(Traveller_ID));
desc Passengers;
select * from Passengers;
-- Questions for table Passengers:  
-- -- Q3. PNR status should be unique and should not be null.
-- -- Q4. Flight Id should not be null.
-- ---------------------------------------------------------------------------------------------------------------------------------------------------
alter table Passengers modify PNR varchar(10) not null unique;
alter table Passengers modify flight_id int not null;
-- ---------------------------------------------------------------------------------------------------------------------------------------------------
-- 5. Create a table senior_citizen_Details Follow the instructions given below: 
-- -- Q1. Column Traveller_ID should not contain any null value.
-- -- Q2. Assign primary key to Traveller_ID
-- -- Q3. Assign foreign key constraint on Traveller_ID such that if any row from passenger table is updated, then the Senior_Citizen_Details table should also get updated.
-- -- --  Also deletion of any row from passenger table should not be allowed.
-- ---------------------------------------------------------------------------------------------------------------------------------------------------
create table if not exists senior_citizen_Details(
Traveller_ID int not null,
senior_citizen varchar(5) null,
Discounted_Price varchar(20) null,
primary key(Traveller_ID),
constraint fk_passeger_senior_citizen
foreign key(Traveller_ID)
references passengers(Traveller_ID)
on update cascade 
on delete restrict);



-- -----------------------------------------------------
-- Table Senior_Citizen_Details
-- -- Q6. Create a new column Age in Passengers table that takes values greater than 18. 
alter table Senior_Citizen_Details add column age int check(age>18);
-- ---------------------------------------------------------------------------------------------------------------------------------------------------
-- 7. Create a table books. Follow the instructions given below: 
-- -- Columns: books_no, description, author_name, cost
-- -- Qa. The cost should not be less than or equal to 0.
-- -- Qb. The cost column should not be null.
-- -- Qc. Assign a primary key to the column books_no.
-- ---------------------------------------------------------------------------------------------------------------------------------------------------
create table books(
books_no varchar(18) primary key,
description varchar(250),
author_name varchar(50),
cost decimal(10,2) not null
check(cost>0));





# Q8. Update the table 'books' such that the values in the columns 'description' and author' must be unique.
alter table books
add constraint new_desc1
unique(description,author_name);

-- ---------------------------------------------------------------------------------------------------------------------------------------------------
-- 9. Create a table bike_sales. Follow the instructions given below: 
-- -- Columns: id, product, quantity, release_year, release_month
-- -- Q1. Assign a primary key to ID. Also the id should auto increment.
-- -- Q2. None of the columns should be left null.
-- -- Q3. The release_month should be between 1 and 12 (including the boundries i.e. 1 and 12).
-- -- Q4. The release_year should be between 2000 and 2010.
-- -- Q5. The quantity should be greater than 0.
-- --------------------------------------------------------------------------
-- Use the following comands to insert the values in the table bike_sales
/*('1','Pulsar','1','2001','7');
('2','yamaha','3','2002','3');
('3','Splender','2','2004','5');
('4','KTM','2','2003','1');
('5','Hero','1','2005','9');
('6','Royal Enfield','2','2001','3');
('7','Bullet','1','2005','7');
('8','Revolt RV400','2','2010','7');
('9','Jawa 42','1','2011','5');*/
-- --------------------------------------------------------------------------
create table bike_sales(
id int primary key  auto_increment,
product varchar(100) not null,
quantity int not null,
release_year int not null,
release_month int not null,
 check(release_month>=1 and release_month<=12),
 check(release_year between 2000 and 2010),
 check(quantity>0));
insert into  bike_sales values('1','Pulsar','1','2001','7');
insert into  bike_sales values ('2','yamaha','3','2002','3');
insert into  bike_sales values('3','Splender','2','2004','5');
insert into  bike_sales values ('4','KTM','2','2003','1');
insert into  bike_sales values('5','Hero','1','2005','9');
insert into  bike_sales values ('6','Royal Enfield','2','2001','3');
insert into  bike_sales values ('7','Bullet','1','2005','7');
insert into  bike_sales values('8','Revolt RV400','2','2010','7');
insert into  bike_sales values ('9','Jawa 42','1','2010','5');


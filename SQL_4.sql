use hr;
select * from employees;
select department_id from employees 
where first_name = 'steven' and last_name = 'king';
select department_name from departments
where department_id = 90;
select department_name from departments
where department_id = (select department_id from employees 
where first_name = 'steven' and last_name = 'king');

#x= 7+3
#y=x-2
# y = (7+3)-2  ## BODMAS
###### SCALAR SUBQUERIES #####
# 
select * from employees where department_id =
(select department_id from departments where
department_name = 'accounting');

# Display average salary of sales deprtment
select avg(salary) from employees where department_id = 
(select department_id from departments where
department_name = 'sales');

# How many employees have salary greater than susan
select count(e2.first_name)
from employees e1, employees e2
where e1.first_name = 'susan'
and e2.salary>=e1.salary;

select count(employee_id) from employees
where salary > 
(select salary from employees where first_name = 'susan');

## List the employees not working in Den's department
select * from employees where department_id <>
(select department_id from employees
where first_name = 'Den');

# Which departments are available at ‘Seattle’ location.

select * from departments 
where location_id=(select location_id from locations
where city='seattle');

# Which employees have salary more than average salary of organization.
select * from employees where salary >
(select avg(salary) from employees);


######## SUBQUERIES RETURNING MULTIPLE VALUES #######

## Name of the departments working with country id 'us'
select department_name from departments where location_id in
(select location_id from locations where country_id = 'us');

## Display the department name for steven
select depatment_name from departments where department_id in (
select department_id from employees where first_name = 'steven');

## department_id = 90 or department_id = 50 ......

# List the details of employees who have more salary than everybody who joined in 2000. 
select * from employees where salary >all(
select salary from employees where year(hire_date) = 2000); 

select * from employees where salary > any(
select max_salary  from jobs where job_id='it_prog' or job_id='st_clerk');

### Inclass solution ###

# Dataset used: titanic_ds.csv
# Use subqueries for every question
 use inclass;
#Q1. Display the first_name, last_name, passenger_no , fare of the passenger who paid less than the  maximum fare. (20 Row)
select first_name,last_name,passenger_no,fare 
 from titanic_ds 
 where fare<
(select max(fare) from titanic_ds); 
#Q2. Retrieve the first_name, last_name and fare details of those passengers who paid fare greater than average fare. (11 Rows)
select first_name,last_name, fare 
 from titanic_ds 
 where fare>
(select avg(fare) from titanic_ds);
#Q4. Display first_name,embark_town where deck is equals to the deck of embark town ends with word 'town' (7 Rows)
select first_name, embark_town from titanic_ds where deck in
(select deck from titanic_ds where embark_town like '%town');

 
# Dataset used: youtube_11.csv
 
#Q5. Display the video Id and the number of likes of the video that has got less likes than maximum likes(10 Rows)
select video_id,likes from youtube_11 where likes < 
(select max(likes) from youtube_11 );

#Q6. Write a query to print video_id and channel_title where trending_date is equals to the trending_date of  category_id 1(5 Rows)
select Video_id,channel_title from youtube_11 where 
Trending_Date in(select Trending_Date from youtube_11 where category_id=1 );
 
#Q7. Write a query to display the publish date, trending date ,views and description where views are more than views of Channel 'vox'.(7 Rows))
 select publish_date, trending_date, views, description 
 from youtube_11 where views >
 (select views from youtube_11 where channel_title ='vox');
 
#Q8. Write a query to display the channel_title, publish_date and the trending_date having category id in between 9 to Maximum category id .
# Do not use Max function(3 Rows)
 select channel_title,publish_date,trending_date 
 from youtube_11 where category_id in (select category_id 
 from youtube_11 where category_id >=9);  ## 9 and onwards
 
 SELECT channel_title, publish_date,trending_date 
 FROM youtube_11 WHERE category_id between 9 and  
(Select category_id FROM youtube_11 ORDER BY category_id DESC LIMIT 1);

 
#Q9. Write a query to display channel_title, video_id and number of view of the video that has received more than  minimum views. (10 Rows)
select channel_title,video_id,views from youtube_11 where views  > 
(select min(views) from youtube_11);

select channel_title,video_id,views from youtube_11 where views  >
(select views from youtube_11 order by views limit 1);



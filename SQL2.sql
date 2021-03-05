CREATE SCHEMA IF NOT EXISTS Video_Games;
USE inclass2;
SELECT * FROM video_games_sales;


# 1. Display the names of the Games, platform and total sales in North America for respective platforms.
select name,platform,sum(NA_Sales) over(partition by platform ) as total_sales_North_America 
from video_games_sales;

# 2. Display the name of the game, platform , Genre and total sales in North America for corresponding Genre as Genre_Sales,total sales for the given platform as Platformm_Sales and also display the global sales as total sales .
# Also arrange the results in descending order according to the Total Sales.
select name,platform,genre,sum(NA_sales) over (partition by genre) as Genre_Sales from video_games_sales
order by Genre_Sales desc;

# 3. Use nonaggregate window functions to produce the row number for each row 
# within its partition (Platform) ordered by release year.
select *,
row_number() over(partition by platform order by Year_of_Release)
from video_games_sales;
# 4. Use aggregate window functions to produce the average global sales of each row within its partition (Year of release). Also arrange the result in the descending order by year of release.
select   Year_of_Release,avg(Global_Sales) over(partition by Year_of_Release ) 
from video_games_sales
order by Year_of_Release desc;

# 5. Display the name of the top 5 Games with highest Critic Score For Each Publisher. 
with temp  as
(select Critic_Score,dense_rank() 
over(partition by Publisher) as c_rank
 from video_games_sales)
select * from temp where c_rank <=5;


------------------------------------------------------------------------------------
# Dataset Used: website_stats.csv and web.csv
------------------------------------------------------------------------------------
# 6. Write a query that displays the opening date two rows forward i.e. the 1st row should display the 3rd website launch date
select * ,lead(launch_date,2) over() opening_date from web;
# 7. Write a query that displays the statistics for website_id = 1 i.e. for each row, show the day, the income and the income on the first day.
select *,first_value(Income) over() first_day_income from website_stats where website_id = 1;

-----------------------------------------------------------------
# Dataset Used: play_store.csv 
-----------------------------------------------------------------
# 8. For each game, show its name, genre and date of release. In the next three columns, show RANK(), DENSE_RANK() and ROW_NUMBER() sorted by the date of release.
SET SQL_SAFE_UPDATES =0;
update play_store set released=str_to_date(released,'%d-%m-%Y');
alter table play_store modify released date;
select name,genre,released, 
RANK() over (order by released) as _Rank,
DENSE_RANK() over(order by released) as DenseRank ,  
ROW_NUMBER() over(order by released) as RowNumber from  play_store;
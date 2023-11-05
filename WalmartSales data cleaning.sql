create database Walmart;
use walmart;
select * from walmartsalesdata;
desc walmartsalesdata;


ALTER TABLE walmartsalesdata
ADD new_date DATE;


update walmartsalesdata
SET new_date = STR_TO_DATE(Date, '%m/%d/%Y');

SELECT DATE_FORMAT(Date, '%m/%d/%Y') AS formatted_date
FROM walmartsalesdata;


-- Time of day

select time ,
 (case 
  when time BETWEEN "00:00:00" and "12:00:00" then "Morning"
  when time BETWEEN "12:01:00" and "16:00:00" then "After-Noon"
  Else "Evening" 
  end) as Time_of_day
  from  walmartsalesdata;
  -- Add a new column Time of day
   alter table walmartsalesdata Add column Time_of_day varchar (30);

update walmartsalesdata
set Time_of_day = (case 
  when time BETWEEN "00:00:00" and "12:00:00" then "Morning"
  when time BETWEEN "12:01:00" and "16:00:00" then "After-Noon"
  Else "Evening" 
  end);
  
  -- Month name
  -- Adding this as new column
  
  alter table walmartsalesdata
  add column  Month_name varchar(30);
  update walmartsalesdata
  set Month_name = Monthname(new_date);
  
  Select new_date, monthname(new_date) as Month_name
   from walmartsalesdata;
  
  -- Day of week
  alter table walmartsalesdata
  add column  Week_days varchar(30);
  
  update walmartsalesdata
  set Week_days = weekday(new_date);
  
  -- Day name
  alter table walmartsalesdata
  add column  Day_name varchar(30);
  update walmartsalesdata
  set Week_days = dayname(new_date);

   -- how many cities;
  
  select distinct city 
  from walmartsalesdata;
  
  -- differnt branches
   select distinct branch 
  from walmartsalesdata;
  
  select 
   distinct city ,branch
  from walmartsalesdata;
  
  -- How many unique product line data have?
  select distinct Product_line,Count(Product_line) as CNT
  from walmartsalesdata
  group by Product_line
  order by CNT;
      
  
  -- total revenue per month
  
  select Month_name,  cast(sum(Total) as  decimal (10,2)) as Total_revenue
  from walmartsalesdata
  group by Month_name
  order by  Total_revenue desc;
  
  -- Which month has largest COGS
  
select Month_name, cast((cogs) as decimal (10,2)) as Largest_COGS
  from walmartsalesdata
  group by Month_name
  order by  sum(cogs) desc;
  
  -- what product line has largest revenue
  
 select Product_line, cast(sum(Total) as  decimal (10,2)) as Total_revenue
  from walmartsalesdata
  group by Product_line
  order by Total_revenue desc;
  
  -- largest revenue by branch
  
  select branch, Month_name,  cast(sum(Total) as  decimal (10,2)) as Total_revenue
  from walmartsalesdata
  group by branch, Month_name
  order by  Total_revenue desc;
  
  -- what peodcut line has the largest vat
  
  select Product_line,cast(avg ( Tax ) as decimal (10,4)) as Avg_tax
  from walmartsalesdata
  group by Product_line
  order by avg ( Tax ) desc;
  
  -- which branch sold more than average product sold?
  
  Select Branch, sum(quantity) as More_than_average
  from walmartsalesdata
  group by Branch
  having  sum(quantity) > (select avg(quantity) from walmartsalesdata );
  
  -- common product line by gender?
  
  select distinct(Product_line),(Gender),count(Gender) as total_count
  from walmartsalesdata
  group by Product_line,Gender
  order by total_count desc;


-- Average  rating of each product line?

select distinct(Product_line), cast(avg(Rating) as decimal (10,3)) as avg_rating
from walmartsalesdata
group by Product_line
order by avg_rating desc;


-- Number of sales made  ineach time of the day in weekday

select count(*) as Total_sales, Time_of_day
from walmartsalesdata
where week_days='Monday'
group by Time_of_day
order by Total_sales desc  ;

-- which custmer brings more revenue

select customer_type, cast(sum(Total) as decimal (10,2))as total_revenue
from walmartsalesdata
group by Customer_type
order by total_revenue desc;

-- which city has largest tax percentage

select (city), 
cast(sum(tax) as decimal (10,2)) as total_tax, 
cast(sum(tax) as decimal (10,2))/(select cast(sum(tax) as decimal (10,2))
from walmartsalesdata)* 100 as Percentage
from walmartsalesdata
group by city
order by total_tax desc;

select city, cast(avg(tax) as decimal (10,2)) as avg_tax
from walmartsalesdata
group by city
order by avg_tax desc;

-- which customer type make the most in vat

select Customer_type, cast(avg(tax) as decimal (10,2)) as avg_tax
from walmartsalesdata
group by Customer_type
order by avg_tax desc;

-- unique customer type data have

select distinct(Customer_type)
from walmartsalesdata;

-- unique payment methods does data have

select distinct(Payment)
from walmartsalesdata;

-- which customer type buys the most

select distinct ( Customer_type), count(*) as Customer_count
from walmartsalesdata
group by Customer_type;

-- gender of majority of customer?

select Gender, count(*) as Gender_Count
from walmartsalesdata
group by Gender
Order by Gender_Count;

-- whats gender distribution per branch?

select Gender, count(*) as Gender_Count
from walmartsalesdata
where  Branch= 'C'
group by Gender
Order by Gender_Count Desc;

-- Which time of the day do customer give most ratings?

Select Time_of_day, Cast(avg(Rating) as decimal (10,2)) as Avg_Rating
from walmartsalesdata
Group by  Time_of_day
Order by Avg_Rating Desc ;

-- Which time of the day customers giving most rating per branch?

Select Time_of_day, Cast(avg(Rating) as decimal (10,2)) as Avg_Rating
from walmartsalesdata
where Branch= 'B'
Group by  Time_of_day
Order by Avg_Rating Desc ;

-- Which day of week has best ratings?

Select Week_days, Cast(avg(Rating) as decimal (10,2)) as Avg_Rating
from walmartsalesdata
Group by  Week_days
Order by Avg_Rating Desc ;

-- Which day of the week has best average ratings per branch?

Select Week_days, Cast(avg(Rating) as decimal (10,2)) as Avg_Rating
from walmartsalesdata
where Branch ='B'
Group by  Week_days
Order by Avg_Rating Desc ;

-- Thats all from the Walmart sales project as i try providing every possible solution to 
-- every possible  Question








  

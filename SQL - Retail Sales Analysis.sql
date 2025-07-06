--create table
drop table if exists retail_sales

create table retail_sales(
              transactions_id	int primary key,
              sale_date	        date,
			  sale_time	        time,
			  customer_id	    int,
			  gender	        varchar(15),
			  age	            int,
			  category	        varchar(15),
			  quantiy	        int,
			  price_per_unit	numeric,
			  cogs	            numeric,
			  total_sale        numeric
			  );

-- check the data for null values

select * from retail_sales
where 
transactions_id = null
or
sale_date is null 
or
sale_time is null 
or
customer_id is null 
or
gender is null 
or
category is null
or
quantiy is null 
or
price_per_unit is null
or
cogs is null
or
total_sale is null ;

--clean the data by deleting null values

delete from retail_sales
where 
quantiy is null 
or
price_per_unit is null
or
cogs is null
or
total_sale is null ;

--  ##data exploration##

-- how much sales we have?

select count(transactions_id) as total_sale
from retail_sales

-- how many unique customers?

select count(distinct customer_id) as total
from retail_sales

-- how many unique category?

select count(distinct category) as total
from retail_sales

--- Data Analysis & Business Key Problems & Answers

--Q1) write a SQL query to retrieve all columns for sales made on 2022-11-05

select * from retail_sales
where sale_date = '2022-11-05'

--Q2) write a SQL query to retrieve all transactions where the category is clothing 
-- and the quantity sold is more than 10 in month of Nov-2022

select *
from retail_sales
where category = 'Clothing' and quantiy >= 4 and sale_date between '2022-11-01' AND '2022-11-30';
 
--Q3) write a query to calculate the total sales (total_sale) for each category.

select category, sum(total_sale) as total_sales
from retail_sales
group by category
order by total_sales

--Q4) write a SQL query to find the average age of customers who purchased items from the beauty category

select round(avg(age),2), category
from retail_sales 
where category = 'Beauty'
group by category

--Q5) Write a SQL query to find all transactions where the total_sale is greater than 1000

select * 
from retail_sales
where total_sale > 1000


--Q6) Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category


select count(transactions_id), gender, category
from retail_sales
group by category, gender


--Q7) Write a SQL query to calculate the average sale for each month. Find out best selling month in each year

select 
      extract(year from sale_date) as year,
	  extract(month from sale_date) as month,
	  avg(total_sale) as monthly_sale
from retail_sales
group by year, month
order by year, monthly_sale desc
 

--Q8)Write a SQL query to find the top 5 customers based on the highest total sales

select customer_id, sum(total_sale) as highest_total_sales
from retail_sales
group by customer_id 
order by highest_total_sales desc limit 5


--Q9) Write a SQL query to find the number of unique customers who purchased items from each category

select count(distinct customer_id), category
from retail_sales
group by category


--Q10) Write a SQL query to create each shift and number of orders (Example Morning <12, Afternoon Between 12 & 17, Evening >17)


with hourly_sale
as
(
select * ,
case 
           when extract(hour from sale_time) < 12 then 'Morning'
		   when extract(hour from sale_time) < 17 then 'Afternoon'
		   else 'Evening'
	   end as shift 
from retail_sales
)
select shift, count(*) from hourly_sale
group by shift


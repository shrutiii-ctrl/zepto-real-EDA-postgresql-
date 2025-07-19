CREATE TABLE zepto (
  sku_id  PRIMARY KEY,
  category VARCHAR(120),
  name VARCHAR(150) NOT NULL,
  mrp NUMERIC(8,2),
  discountPercent NUMERIC(5,2),
  availableQuantity INTEGER,
  discountedSellingPrice NUMERIC(8,2),
  weightInGms INTEGER,
  outOfStock BOOLEAN,
  quantity INTEGER
);

--Count Of Rows

SELECT COUNT (*) FROM zepto;
--Sample Data

Select * from zepto
limit 10;

--NUll Values

Select * from zepto where 
name is Null
or
category is Null
or
mrp is Null
or
discountpercent is Null
or
availablequantity is Null
or
discountedSellingPrice is Null
or
weightingms is Null
or
outofstock is Null
or
quantity is Null
;

--different product categories

select distinct category
from zepto
order by category;

--product in stock vs out of stock

SELECT outofstock, count(sku_id)
from zepto
group by outofstock;


--Product Names present multiple times

select name,count(sku_id) as "Number of SKUs"
from zepto
group by name
having count(sku_id) > 1
order by count (sku_id) desc;

--Data cleaning 

--products with prixe = 0

Select * from zepto 
where mrp=0 
or 
discountedsellingprice=0;

--delete the row where mrp is zero
Delete from zepto 
where mrp =0;


--Convert paise to Rupee

update zepto
set mrp = mrp/100.0,
discountedsellingprice = discountedsellingprice/100.0;

select mrp,discountedsellingprice from zepto;

-- Q1. Find the top 10 best-value products based on the discount percentage. 


	select distinct name ,mrp, discountpercent
	from zepto
	order by discountpercent desc
	limit 10;



	
-- Q2. What are the Products with High MRP but Out of Stock 

	select distinct name,mrp 
	from zepto
	where outofstock = True and mrp >300
	order by mrp desc;

-- Q3. Calculate Estimated Revenue for each category
	
select category, 
sum(discountedsellingprice * availablequantity) AS total_revenue
from zepto
group by category
order by total_revenue;

-- Q4. Find all products where MRP is greater than ₹500 and discount is less than 10%.
	
	select distinct name , mrp, discountpercent
	from zepto 
	where mrp>500 
	and discountpercent <10
	order by
	mrp desc ,discountpercent desc;

-- Q5. Identify the top 5 categories offering the highest average discount percentage.

	select category,
	round(avg(discountpercent),2) as avg_discount
	from zepto
	group by category
	order by avg_discount desc
	limit 5;

-- Q6. Find the price per gram for products above 100g and sort by best value.

	select distinct name, weightingms,discountedsellingprice,
	round(discountedsellingprice/weightingms,2) as price_per_gram
	from zepto
	where weightingms >=100
	order by price_per_gram;

-- Q7. Group the products into categories like Low, Medium, Bulk. 

	select distinct name , weightingms,
	case when weightingms <1000 then 'Low'
		when weightingms <5000 then 'meduim'
		else 'bulk'
		end as weight_category
	from zepto;

-- Q8. What is the Total Inventory Weight Per Category  

select category ,
sum(weightingms * availablequantity) as total_weight
from zepto
group by category
order by total_weight;














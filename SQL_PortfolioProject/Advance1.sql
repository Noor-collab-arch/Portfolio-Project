
 -- Dynamic Pricing Simulation: Challenge students to analyze how price changes for
-- products impact sales volume, revenue, and customer behavior

use fictional_retail_company;

# Impact of Price Fluctuations Over Time
select
    pd.product_name,
    pd.price,
    SUM(sd.quantity_sold) AS total_quantity_sold,
    SUM(sd.total_amount) AS total_revenue,
    COUNT(DISTINCT sd.customer_id) AS unique_customers
From 
   sales_data sd
join 
   products_data pd ON sd.product_id = pd.product_id
group by 
     pd.product_name, pd.price
order by 
      5 desc; 
      # as we can see highigest the price have only 5 customers, product29 mostly bought by 17 customers with price 57.76 and 63 quantity sold



-- 2nd part 2.1 Identify Customers with Frequent Purchase

Select
    cd.customer_id,
    cd.first_name,
    cd.last_name,
    pd.product_name,
    sd.sale_date,
    LAG(sd.sale_date) OVER (PARTITION BY sd.customer_id ORDER BY sd.sale_date) AS last_purchase_date,
    DATEDIFF(sd.sale_date, LAG(sd.sale_date) OVER (PARTITION BY sd.customer_id ORDER BY sd.sale_date)) AS days_between_purchases
from 
    sales_data sd
Join 
   products_data pd ON sd.product_id = pd.product_id
Join
  customers_data cd ON sd.customer_id = cd.customer_id
order by
    cd.customer_id, sd.sale_date;
#This query calculates the days between each customer's successive purchases, helping to identify high-frequency buyers.
#The LAG() window function is used to compare each purchase with the previous one.


-- 2.2 Track Customer Purchase Trends
select 
    cd.customer_id,cd.first_name, 
    count(sd.sale_id) as order_by_customers, date_format(sale_date,'%Y-%m') as sale_month
from 
    customers_data cd 
join 
    sales_data sd
on 
   cd.customer_id=sd.customer_id
group by 
    cd.customer_id,sale_month
having 
    sale_month > '2024-06'
order by 
      3 desc; # customer 94 have 4 orders in oct month in last 6 months 
#This query identifies customers who are making more than a certain number of purchases per month, which can be a sign of loyal or high-frequency buyers.
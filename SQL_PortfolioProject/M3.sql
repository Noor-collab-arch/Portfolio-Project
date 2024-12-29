-- Module 3: Inventory and Product Management
use fictional_retail_company;

-- 6. Stock Management:
-- ○ Write a query to find products that are running low in stock (below a threshold like
-- 10 units) and recommend restocking amounts based on past sales performance.

-- final query
with quantity_in_product as
(
select 
     product_id, sum(stock_quantity) as in_stock
from 
    products_data
group by 
     product_id
      
),quantity_sold as
(
select 
    product_id, sum(quantity_sold) as quant_sold,avg(quantity_sold) as avg_quant_sold,count(sale_id) as orders
from 
   sales_data 
group by 
    product_id
-- order by quant_sold desc
)
select 
    qs.*,qip.in_stock,
case
    when qip.in_stock < 20 Then 'add stock!!!'
    else 'satisfied stock'
    end as 'stock_recommendaton'
from 
    quantity_in_product qip join quantity_sold qs
on 
  qip.product_id=qs.product_id
having 
      stock_recommendaton='add stock!!!'    # q6 finish here
order by 
      4 desc;



-- 7. Inventory Movements Overview:
-- Create a report showing the daily inventory movements (restock vs. sales) for
-- each product over a given period


-- final query done 
select 
    product_id, movement_date,
	sum( case when movement_type='IN' Then quantity_moved End) as totalrestock,
    sum(case when  movement_type='OUT' Then quantity_moved End) as totalsale
from 
    inventory_movements_data
WHERE 
    movement_date BETWEEN '2024-01-01' AND '2024-01-31'
group by 
     product_id, movement_date
order by 
      product_id, movement_date;



-- 8. Rank Products::
-- ○ Rank products in each category by their prices.
-- supporting

-- final
select *,
rank() over (partition by category order by price desc) as price_rank
from 
   products_data
order by 
     category,price_rank;


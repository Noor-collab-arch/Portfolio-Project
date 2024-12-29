-- Module 1: Sales Performance Analysis

use fictional_retail_company;

    
-- Calculate the total sales amount per month, including the number of units sold
-- and the total revenue generated.

select 
      monthname(sl.sale_date) as sale_month,
      sum(sl.total_amount) as ttl_sale_month,
      sum(sl.quantity_sold) as ttl_quant_sold,
      sum(sl.quantity_sold*pd.price*(1-sl.discount_applied/100)) as ttl_revenue
from 
    sales_data sl join products_data pd
on 
     sl.product_id=pd.product_id
group by 
       sale_month;

-- Average Discount per Month:
-- Calculate the average discount applied to sales in each month and assess how
-- discounting strategies impact total sales.



-- final query
  
select 
     monthname(sl.sale_date) as sale_month,
     sum(sl.quantity_sold) as ttl_quant,
     sum(sl.total_amount) as totals_sale_after_disc,
     sum(pd.price*sl.quantity_sold) as sale_before_disc,
avg
  ((pd.price*sl.quantity_sold) - sl.total_amount/sl.quantity_sold) as avg_discount
from 
   sales_data sl join products_data pd
on 
  pd.product_id=sl.product_id
group by 
    sale_month
order by 
    5 desc;
# higher discount higher the total sales



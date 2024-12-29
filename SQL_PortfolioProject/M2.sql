-- Module 2: Customer Behavior and Insights
use fictional_retail_company;

-- 3. Identify high-value customers:
--  Which customers have spent the most on their purchases? Show their details


-- final query

select 
    sl.customer_id,cd.*,
    sum(sl.total_amount) as purchases
from
    sales_data sl join customers_data cd
on 
    sl.customer_id= cd.customer_id
group by 
     sl.customer_id
order by  
    purchases desc;

-- solving with windows function

select sl.customer_id,cd.*,
sum(sl.total_amount) over (partition by cd.customer_id) as purchases
from sales_data sl join customers_data cd
on sl.customer_id= cd.customer_id
order by purchases desc;


-- 5. Customer Segmentation:
-- ○ Use SQL to create customer segments based on their total spending (e.g., Low
-- Spenders, High Spenders).


-- final
with totalpurchase as
(
select 
    customer_id ,
    sum(total_amount) as total_spending
from
    sales_data
group by  
     customer_id
)
SELECT 
    sd.customer_id,
    tp.total_spending,
    CASE 
        WHEN tp.total_spending BETWEEN 100 AND 2700 THEN 'Low'
        WHEN tp.total_spending BETWEEN 2701 AND 5300 THEN 'Medium'
        WHEN tp.total_spending > 5300 THEN 'High'
        ELSE 'Undefined'
    END AS spending_segment
FROM 
    sales_data sd join totalpurchase tp
    on sd.customer_id=tp.customer_id
ORDER BY 
    total_spending asc;




-- 4 Identify the oldest Customer:
-- Find the details of customers born in the 1990s, including their total spending and
-- specific order details.

-- supporting
select * from sales_data;
select * from products_data;
select * from customers_data
where year(date_of_birth) between 1990 and 1999;


select cd.* , sd.product_id,sd.total_amount
from customers_data cd join sales_data sd 
on cd.customer_id=sd.customer_id
where year(cd.date_of_birth) between 1990 and 1999;

-- final query
with cust_sale as
(
select cd.* , sd.product_id,sd.total_amount
from customers_data cd left join sales_data sd 
on cd.customer_id=sd.customer_id
where year(cd.date_of_birth) between 1990 and 1999

)
select pd.product_name,pd.price, cs.*
from cust_sale cs join products_data pd  
on pd.product_id=cs.product_id;







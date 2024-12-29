-- Predictive Analytics: Use past data to predict which customers are most likely to churn
-- and recommend strategies to retain them

use fictional_retail_company;

--  3.1 Identify Potential Churn Customers (Inactive for Too Long)

select 
    cd.customer_id, cd.first_name, cd.last_name,sd.total_amount,
    max(cd.last_purchase_date) as last_purchase_date,
    datediff(current_date, max(cd.last_purchase_date)) as days_since_last_purchase
from
    sales_data sd join  customers_data cd 
on 
    sd.customer_id = cd.customer_id
group by 
    cd.customer_id,sd.total_amount
#having datediff(current_date, max(cd.last_purchase_date)) >30;
order by 
    6 desc
limit 10;
# this query give us the data of inactive customers since last 30 days
-- Module 4: Advanced Analytics
-- 9. Average order size:
-- ○ What is the average order size in terms of quantity sold for each product?
-- supporting 
select * from products_data
where product_id='29';
select * from sales_data;
select * from products_data;

-- final query 
SELECT 
    p.product_id,
    p.product_name,
    p.category,
    AVG(s.sale_id) AS average_order_size
FROM 
    products_data AS p
JOIN 
    sales_data AS s ON p.product_id = s.product_id
GROUP BY 
    p.product_id, 
    p.product_name, 
    p.category
ORDER BY 
average_order_size DESC;




-- 10. Recent Restock Product:
-- ○ Which products have seen the most recent restocks

-- final
select * from inventory_movements_data;

select 
    ind.product_id, p.product_name,max(ind.movement_date) as recenlty_restock
from 
     inventory_movements_data ind join products_data p
on 
   ind.product_id=p.product_id
group by 
     ind.product_id
order by 
    recenlty_restock desc
limit 10;

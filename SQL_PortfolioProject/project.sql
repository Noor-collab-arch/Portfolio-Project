create database fictional_retail_company;

use fictional_retail_company;

select * from customers_data;

-- 1.setting customers_data table 
select * from customers_data;

# add primary key in customer table



alter table customers_data
modify customer_id int Auto_increment primary key;


-- changing data type of date_of_birth text to date

alter table customers_data
modify date_of_birth date;

-- changing data type of registration_date text to date
alter table customers_data
modify registration_date date;

-- changing data type of last_purchase_date text to date
alter table customers_data
modify last_purchase_date date;



-- 2 setting products_data 

select * from products_data;

-- adding primary key product_id
alter table products_data
modify product_id int Auto_increment Primary key;

-- changing data type of date_added text to date

alter table products_data
modify date_added date;



-- 3 setting sales_data 
select * from sales_data;


-- adding primary key sale_id

alter table sales_data
modify sale_id int auto_increment primary key;


-- set customer id foriegn key in sales table

alter table sales_data
add constraint fk_customer
foreign key (customer_id)
references customers_data(customer_id);

-- set product id foriegn key in sales table

alter table sales_data
add constraint fk_products
foreign key (product_id)
references products_data(product_id);


-- changing datatype sale_date text to date
alter table sales_data
modify sale_date date;



-- 4 setting inventory_movements
select * from inventory_movements_data;

-- movement_id as primary key 
alter table inventory_movements_data
modify movement_id int auto_increment primary key;

-- setting product id as foreign key in  inventory_movements
alter table  inventory_movements_data
add constraint fk2_products
foreign key(product_id)
references products_data(product_id);

-- movement_date datatype from text to date
alter table inventory_movements_data
modify movement_date date;


select * from inventory_movements_data;
select * from customers_data;
select * from products_data;
select * from sales_data;
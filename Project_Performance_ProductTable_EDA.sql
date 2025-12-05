
/* DATA CLEANING for product datasets
Create a new table for Product Datasets

CREATE TABLE product_table
SELECT *
FROM product_table_dirty_2024_2025 ;

*/

Select * from product_table;


/* Identify the DUPLICATE VALUES*/

SELECT Product_Id, COUNT(*) AS count_duplicates
FROM product_table
GROUP BY product_id
HAVING COUNT(*) > 1;


/*Alter the Availability_Location Column */ 

Select distinct availability_location
from product_table;
/*
UPDATE product_table
SET availability_location = 
    CASE 
        WHEN LOWER(TRIM(availability_location)) = 'online' THEN 'Online'
        WHEN LOWER(TRIM(availability_location)) IN ('in store', 'in_store') THEN 'In Store'
        WHEN LOWER(TRIM(availability_location)) = 'both' THEN 'Both'
        ELSE availability_location
    END;
*/

Select distinct Supplier_Name
from product_table;

/*Format the Supplier Name column */ 

/*
UPDATE product_table
SET Supplier_Name = TRIM(Supplier_Name);


UPDATE product_table
SET Supplier_Name = REPLACE(REPLACE(Supplier_Name, '_', ' '), '.', '');


UPDATE product_table
SET Supplier_Name = CONCAT(
    UPPER(SUBSTRING(Supplier_Name, 1, 1)),
    LOWER(SUBSTRING(Supplier_Name, 2))
);

UPDATE product_table
SET Supplier_Name = CASE 
    WHEN LOWER(TRIM(Supplier_Name)) IN ('acme supplies', 'acme_supplies', 'acme supplies  ', 'acme_supplies__') THEN 'ACME Supplies'
    WHEN LOWER(TRIM(Supplier_Name)) IN ('metrosupply', 'metrosupply__') THEN 'MetroSupply'
    WHEN LOWER(TRIM(Supplier_Name)) IN ('bestgoods', 'bestgoods__') THEN 'BestGoods'
    WHEN LOWER(TRIM(Supplier_Name)) IN ('qualityhub') THEN 'QualityHub'
    WHEN LOWER(TRIM(Supplier_Name)) IN ('philsource', 'philsource__') THEN 'PhilSource'
    WHEN LOWER(TRIM(Supplier_Name)) IN ('sunrise co', 'sunrise co', 'sunrise_co') THEN 'Sunrise Co.'
    WHEN LOWER(TRIM(Supplier_Name)) IN ('global traders', 'global_traders') THEN 'Global Traders'
    ELSE Supplier_Name
END;

UPDATE product_table
SET Supplier_Name = 'Others'
WHERE Supplier_Name= '';

*/

Select distinct Supplier_Name
from product_table;

Select * from product_table;

ALTER TABLE product_table
ADD COLUMN cleaned_order_date DATE ;

/* Standardized date Format*/

/*
-- 1. Format yyyy-mm-dd
UPDATE product_table
SET cleaned_order_date = STR_TO_DATE(last_order_date, '%Y-%m-%d')
WHERE last_order_date REGEXP '^[0-9]{4}-[0-9]{2}-[0-9]{2}$'; 


-- 2. Format dd/mm/yyyy
UPDATE product_table
SET cleaned_order_date = STR_TO_DATE(Last_order_date, '%d/%m/%Y')
WHERE last_order_date REGEXP '^[0-9]{2}/[0-9]{2}/[0-9]{4}$'; 

-- 3. Format Mon dd yyyy (Jan 13 2025)
UPDATE product_table
SET cleaned_order_date = STR_TO_DATE(Last_order_date, '%b %d %Y')
WHERE last_order_date REGEXP '^[A-Za-z]{3} [0-9]{2} [0-9]{4}$';

-- 4. Format Month dd yyyy (January 13 2025)
UPDATE product_table
SET cleaned_order_date = STR_TO_DATE(Last_order_date, '%M %d %Y')
WHERE last_order_date REGEXP '^[A-Za-z]+ [0-9]{2} [0-9]{4}$';

-- 5. Format mm-dd-yyyy (11-21-2025)
UPDATE product_table
SET cleaned_order_date = STR_TO_DATE(Last_order_date, '%m-%d-%Y')
WHERE last_order_date REGEXP '^[0-9]{2}-[0-9]{2}-[0-9]{4}$'; 

Select distinct Last_Order_Date,cleaned_order_date from product_table;

-- 6.Format dd-Month-yy ( 12-Jan-25)
UPDATE product_table 
SET cleaned_order_date = STR_TO_DATE(Last_order_date, '%d-%b-%Y')
WHERE last_Order_Date REGEXP '^[0-9]{2}-[A-Za-z]{3}-[0-9]{2}$';
*/

-- Create a new table for cleaned columns of the Product table 

CREATE TABLE product_table_cleaned
SELECT Product_Id,
	Product_Name,
	Product_Category,
    Unit_Cost,
    Unit_Profit,
    Product_Stack,
    Availability_Location,
    Supplier_Name,
    Total_Required_Stocks,
    Reorder_Quantity_Level,
    Reorder_Quantity,
    cleaned_order_date as Last_Order_Date	
FROM product_table ;



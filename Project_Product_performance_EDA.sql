/*Data Cleaning for Order_Table*/
/*create a duplicate table so that there is a backup copy of raw data*/
/*
CREATE TABLE Order_table_cleaned2 
SELECT *
FROM order_table_dirty_2024_2025; */

/*	Querry the new table*/ 

Select *
from order_table_cleaned2; 

/*Remove spaces from the left and right*/ 

SELECT TRIM(Customer_First_Name) Customer_First_Name ,trim(Customer_Last_Name) Customer_Last_Name
FROM order_table_cleaned2;


/*Concatenate the First_Name and the Last_Name and add update the table  */

/*
ALTER TABLE order_table_cleaned2
ADD COLUMN Customer_Full_Name VARCHAR(255);

UPDATE order_table_cleaned2
SET Customer_Full_Name = CONCAT(Customer_First_Name, ' ', Customer_Last_Name);

/*Analyze and Alter the Age group Column*/

Select Distinct Customer_Age_Group
From order_table_cleaned2 ;

/*
UPDATE order_table_cleaned2
Set Customer_Age_Group=
	Case 
		When Customer_Age_Group= '18-25' OR Customer_Age_Group='18 -25' Then 'Young'
        When Customer_Age_Group= '26-35' OR Customer_Age_Group='26 - 35' OR  Customer_Age_Group= 'Young Adult' THEN 'Young Adult'
		When Customer_Age_Group= '36-45'  THEN 'Adult'
		When Customer_Age_Group= '46-55'  THEN 'Middle Age'
        When Customer_Age_Group= '56+' OR Customer_Age_Group='Senior' THEN 'Senior'
        Else 'Senior'
        End ;
*/

Select * from order_table_cleaned2; 

/*Analyze and Alter The Order_Date . The format must be in "yyyy-mm-dd"  */

select distinct order_date
from order_table_cleaned2 ;

/*1️⃣ Add a new column for cleaned dates
ALTER TABLE order_table_cleaned2
ADD COLUMN cleaned_order_date DATE;*/

/*
-- 1. Format yyyy-mm-dd
UPDATE order_table_cleaned2
SET cleaned_order_date = STR_TO_DATE(order_date, '%Y-%m-%d')
WHERE order_date REGEXP '^[0-9]{4}-[0-9]{2}-[0-9]{2}$'; 


-- 2. Format dd/mm/yyyy
UPDATE order_table_cleaned2
SET cleaned_order_date = STR_TO_DATE(order_date, '%d/%m/%Y')
WHERE order_date REGEXP '^[0-9]{2}/[0-9]{2}/[0-9]{4}$'; 

-- 3. Format Mon dd yyyy (Jan 13 2025)
UPDATE order_table_cleaned2
SET cleaned_order_date = STR_TO_DATE(order_date, '%b %d %Y')
WHERE order_date REGEXP '^[A-Za-z]{3} [0-9]{2} [0-9]{4}$';

-- 4. Format Month dd yyyy (January 13 2025)
UPDATE order_table_cleaned2
SET cleaned_order_date = STR_TO_DATE(order_date, '%M %d %Y')
WHERE order_date REGEXP '^[A-Za-z]+ [0-9]{2} [0-9]{4}$';

-- 5. Format mm-dd-yyyy (11-21-2025)
UPDATE order_table_cleaned2
SET cleaned_order_date = STR_TO_DATE(order_date, '%m-%d-%Y')
WHERE order_date REGEXP '^[0-9]{2}-[0-9]{2}-[0-9]{4}$'; 
*/

/*Preview the result of the cleaned date column*/

Select order_date,cleaned_order_date 
from order_table_cleaned2; 

/*Clean the Order_Type Coloumn */

start transaction ;

UPDATE order_table_cleaned2
Set Order_Type=
	Case 
		When Order_Type= 'online' Then 'Online'
        When Order_Type= 'In-Store' OR Order_Type='in store' THEN 'In Store'
        When Order_Type IS NULL  THEN 'Others'
        End ;

Commit;

Select distinct order_Type
From order_table_cleaned2;

/*Querry the cleaned columns */ 
Select 
	Order_Id,
	Product_Id,
    Customer_Id,
	Customer_Full_Name,
	Customer_Age_Group,
	cleaned_order_date as Order_Date,
	Order_Type,
	Order_Quantity,
	Sales_per_Order,
	Profit_per_Order
From order_table_cleaned2 ;

/*Create a new table for the cleaned datasets*/

START TRANSACTION ;

CREATE TABLE Order_table
Select 
	Order_Id,
	Product_Id,
    Customer_Id,
	Customer_Full_Name,
	Customer_Age_Group,
	cleaned_order_date as Order_Date,
	Order_Type,
	Order_Quantity,
	Sales_per_Order,
	Profit_per_Order
From order_table_cleaned2 ;

Select * from order_table ;









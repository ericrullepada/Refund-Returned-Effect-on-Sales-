SELECT * FROM product_returned_table_dirty_2024_2025;

/*

CREATE TABLE product_returned_table_cleaned
SELECT *
FROM product_returned_table_dirty_2024_2025 ;

*/

SELECT * FROM product_returned_table_cleaned;

-- Standardize the Reason_for_returning column 
/*
UPDATE product_returned_table_cleaned
SET Reason_for_Returning = CASE
    WHEN Reason_for_Returning REGEXP 'not[ _]?as[ _]?described' THEN 'Not as described'
    WHEN Reason_for_Returning REGEXP 'missing[ _]?parts?' THEN 'Missing parts'
    WHEN Reason_for_Returning REGEXP 'late[ _]?delivery' THEN 'Late delivery'
    WHEN Reason_for_Returning REGEXP 'defect' THEN 'Defective'
    WHEN Reason_for_Returning REGEXP 'wrong[ _]?size' THEN 'Wrong size'
    WHEN Reason_for_Returning REGEXP 'damaged[ _]?item?' THEN 'Damaged item'
    WHEN Reason_for_Returning REGEXP 'changed[ _]?mind' THEN 'Changed mind'
    ELSE 'Other'
END;

*/

-- Standardize the Date_Refunded Column into yyyy-mm-dd format 
/*
-- 1. Format yyyy-mm-dd
UPDATE product_returned_table_cleaned
SET Date_Refunded = STR_TO_DATE(Date_Refunded, '%Y-%m-%d')
WHERE Date_Refunded REGEXP '^[0-9]{4}-[0-9]{2}-[0-9]{2}$'; 


-- 2. Format dd/mm/yyyy
UPDATE product_returned_table_cleaned
SET Date_Refunded = STR_TO_DATE(Date_Refunded, '%d/%m/%Y')
WHERE Date_Refunded REGEXP '^[0-9]{2}/[0-9]{2}/[0-9]{4}$'; 

-- 3. Format Mon dd yyyy (Jan 13 2025)
UPDATE product_returned_table_cleaned
SET Date_Refunded = STR_TO_DATE(Date_Refunded, '%b %d %Y')
WHERE Date_Refunded REGEXP '^[A-Za-z]{3} [0-9]{2} [0-9]{4}$';

-- 4. Format Month dd yyyy (January 13 2025)
UPDATE product_returned_table_cleaned
SET Date_Refunded = STR_TO_DATE(Date_Refunded, '%M %d %Y')
WHERE Date_Refunded REGEXP '^[A-Za-z]+ [0-9]{2} [0-9]{4}$';

-- 5. Format mm-dd-yyyy (11-21-2025)
UPDATE product_returned_table_cleaned 
SET Date_Refunded = STR_TO_DATE(Date_Refunded, '%m-%d-%Y')
WHERE Date_Refunded REGEXP '^[0-9]{2}-[0-9]{2}-[0-9]{4}$';


-- 6.Format dd-Month-yy ( 12-Jan-25)
UPDATE product_returned_table_cleaned
SET Date_Refunded = STR_TO_DATE(Date_Refunded, '%d-%b-%Y')
WHERE Date_Refunded REGEXP '^[0-9]{2}-[A-Za-z]{3}-[0-9]{2}$';

-- 7.Format dd-mm-yyyy
UPDATE product_returned_table_cleaned
SET Date_Refunded = STR_TO_DATE(Date_Refunded, '%d-%m-%Y')
WHERE Date_Refunded REGEXP '^[0-9]{2}-[0-9]{2}-[0-9]{4}$';

*/

Select * from  product_returned_table_cleaned;






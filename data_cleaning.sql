-- =========================================
-- Data Issues Identified and Fixes Applied
-- =========================================

-- 1. Encoding Issue in the Transmission Column
--    The value 'DoubleÂ Overhead Camshaft' appears due to character encoding issues.
--    It should be corrected to 'Double Overhead Camshaft' (remove invalid characters).

UPDATE dirty_sales_data
SET "Transmission" = REPLACE("Transmission", 'Â', '')
WHERE "Transmission" LIKE '%Â%';

-- 2. Model Names Misinterpreted as Dates
--    Model names like '9-5' and '9-3' were imported as dates (e.g., '05-Sep', '03-Sep').

-- 2.1 Fix: Replace incorrectly parsed model '05-Sep' with correct model name '9-5'
UPDATE dirty_sales_data
SET "Model" = '9-5'
WHERE "Model" = '05-Sep';

-- 2.2 Fix: Replace incorrectly parsed model '03-Sep' with correct model name '9-3'
UPDATE dirty_sales_data
SET "Model" = '9-3'
WHERE "Model" = '03-Sep';

-- Note: This usually occurs during CSV or Excel import — make sure to import 'Model' as TEXT.

-- 3. Incorrect Data Types in Columns
--    Some fields were assigned types that don't match their real-world usage.

-- 3.1 Dealer Number should not contain hyphens and should be numeric.

-- Step 1: Add a new column with the correct type
ALTER TABLE dirty_sales_data ADD COLUMN dealer_number_temp VARCHAR;

-- Step 2: Copy and clean the data (remove hyphens)
UPDATE dirty_sales_data
SET dealer_number_temp = REPLACE("Dealer_No", '-', '');

-- Step 3: Drop the original incorrect column
ALTER TABLE dirty_sales_data DROP COLUMN "Dealer_No";

-- Step 4: Rename the cleaned column
ALTER TABLE dirty_sales_data RENAME COLUMN dealer_number_temp TO dealer_number;

-- Step 5: Convert it to numeric
ALTER TABLE dirty_sales_data
ALTER COLUMN dealer_number TYPE NUMERIC USING dealer_number::NUMERIC;


-- 3.2 Fix Data Type for "Date" column
ALTER TABLE dirty_sales_data
ALTER COLUMN "Date" TYPE DATE USING "Date"::DATE;

-- 3.3 Fix Data Type for "Annual_Income"
ALTER TABLE dirty_sales_data
ALTER COLUMN "Annual_Income" TYPE NUMERIC USING "Annual_Income"::NUMERIC;

-- 3.4 Fix Data Type for "Phone"
-- Note: Consider using VARCHAR instead of INTEGER to preserve formatting/leading zeros.
ALTER TABLE dirty_sales_data 
ALTER COLUMN "Phone" TYPE INTEGER USING ("Phone"::INTEGER)


-- 4. No Duplicates or Null Values Detected
WITH cte_Check_Duplicates AS (
	SELECT *,
	       ROW_NUMBER() OVER (
	           PARTITION BY car_id, "Date", "Customer_Name", "Gender", "Annual_Income", 
	                        "Dealer_Name", "Company", "Model", "Engine", "Transmission", 
	                        "Color", "Price", "Body Style", "Phone", "Dealer_Region", dealer_number
	           ORDER BY car_id
	       ) AS n
	FROM public.dirty_sales_data
)
SELECT *
FROM cte_Check_Duplicates
WHERE n > 1;
--    The dataset appears to be clean in terms of duplication and missing values.


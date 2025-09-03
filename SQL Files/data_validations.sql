-- =========================================
-- Data Validation And Business Problems
-- =========================================
--Please Note that the calculations were done after cleaning the data
--1. Total Sales in the last two years:
SELECT 
	SUM("Price") as current_year_sales
FROM public.dirty_sales_data
--1.1 Total Sales for current and previous year:
SELECT
	date_part('year',"Date")
	,SUM("Price") as current_year_sales
FROM public.dirty_sales_data
GROUP BY 1	
ORDER BY 1
--2. UNIT SOLD in the last two years:
SELECT 
	,count(*) as unit_sold
FROM public.dirty_sales_data
--2.1 UNIT SOLD for current and previous year:
SELECT
	date_part('year',"Date")
	,count(*) as unit_sold
FROM public.dirty_sales_data
GROUP BY 1	
ORDER BY 1
--4. Model breakdown of sales
SELECT 
	"Company"
	,SUM("Price") as total_sales
FROM public.dirty_sales_data
GROUP BY 1
ORDER BY 1
--4.1 Model breakdown of unit_sold
SELECT 
	"Company"
	,count(*) as unit_sold
FROM public.dirty_sales_data
GROUP BY 1
ORDER BY 1
--5. Body style breakdown of unit_sold
SELECT 
	"Body Style"
	,SUM("Price") as total_sales
FROM public.dirty_sales_data
GROUP BY 1
ORDER BY 1
--6. Gender breakdown of unit_sold
SELECT 
	"Gender"
	,count(*) as unit_sold
FROM public.dirty_sales_data
GROUP BY 1
ORDER BY 1
--7. Which months performed better and which was the worse?
WITH cte_current_year
AS
(
	SELECT 
	date_part('month',"Date") as month
	,SUM("Price") as current_year_sales
	FROM public.dirty_sales_data
	WHERE date_part('year',"Date")=
							(
							SELECT 
							MAX(date_part('year',"Date"))
							FROM dirty_sales_data
							)
	GROUP BY 1
)
,cte_previous_year
as
(
	SELECT 
	date_part('month',"Date") as month
	,SUM("Price") as prev_year_sales
	FROM public.dirty_sales_data
	WHERE date_part('year',"Date")=
							(
							SELECT 
							MAX(date_part('year',"Date"))-1
							FROM dirty_sales_data
							)
	GROUP BY 1
)
,cte_calculation_table
AS
(
	SELECT 
		c.month
		,c.current_year_sales
		,COALESCE
		(
			LAG(c.current_year_sales)OVER(ORDER BY c.month)
			,CASE WHEN c.month=1 THEN(
				SELECT 
					prev_year_sales
				FROM cte_previous_year
				WHERE
					month=12
			)ELSE NULL END
		) AS previous_month
	FROM cte_current_year c
)
SELECT 
	month
	,current_year_sales
	,previous_month
	,CASE 
	  WHEN previous_month = 0 OR previous_month IS NULL THEN NULL
	  ELSE ROUND(((current_year_sales::numeric / previous_month) - 1) * 100, 2)
	END AS mom
FROM cte_calculation_table
--Result: In terms of sales growth mom we had an excellent month: September  while January was the worse performing month.
--Number of Rows
SELECT DISTINCT count(*) FROM public.dirty_sales_data

--Conclusion:
--All calculated values match the figures presented in the Power BI dashboard, confirming data accuracy.


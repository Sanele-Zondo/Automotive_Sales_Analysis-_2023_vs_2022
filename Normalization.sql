-- =========================================
-- Normalization
-- =========================================
--1. BUILDING TABLE: transmission_table
-- DROP TABLE IF EXISTS public.transmission_table;
CREATE TABLE IF NOT EXISTS public.transmission_table
(
    trans_id SERIAL NOT NULL,
    transmission character varying(50),
    engine character varying(50),
    CONSTRAINT transmission_table_pkey PRIMARY KEY (trans_id)
)
------Insert Data
INSERT INTO transmission_table(transmission,engine)
SELECT 
	"Transmission"
	,"Engine" 
FROM public.dirty_sales_data
GROUP BY 1,2
SELECT * FROM transmission_table
-- No Duplicates since GROUP BY is used

--2. BUILDING TABLE: car_table
-- DROP TABLE IF EXISTS public.car_table;
CREATE TABLE IF NOT EXISTS public.car_table
(
    car_id character varying(30) NOT NULL,
    sale_date date NOT NULL,
    color character varying(30) NOT NULL,
    price numeric NOT NULL,
    cust_id integer NOT NULL,
    model_id integer NOT NULL,
    transmission_id integer NOT NULL,
    dealer_id integer NOT NULL,
    CONSTRAINT car_table_cust_id_fkey FOREIGN KEY (cust_id)
        REFERENCES public.customer_table (cust_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT car_table_dealer_id_fkey FOREIGN KEY (dealer_id)
        REFERENCES public.dealer_table (dealer_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT car_table_model_id_fkey FOREIGN KEY (model_id)
        REFERENCES public.model_table (model_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
	CONSTRAINT car_table_transmission_id_fkey FOREIGN KEY (transmission_id)
	    REFERENCES public.transmission_table (trans_id)
	    ON UPDATE NO ACTION
	    ON DELETE NO ACTION
)
------Insert Data
INSERT INTO car_table(car_id,sale_date,color,price,cust_id,model_id,transmission_id,dealer_id)
WITH cte_car_table 
AS
(
	SELECT 
		O.car_id
		,O."Date" as sale_date
		,O."Color" as color
		,O."Price" as price
		,c.cust_id
		,m.model_id
		,t.trans_id
		,d.dealer_id
		,row_number()OVER(Partition by car_id) as n--AVOID DUPLICATION OF CAR_ID
	FROM dirty_sales_data O
	INNER JOIN customer_table c
	ON(O."Customer_Name"=c.customer_name and O."Phone"=c.phone and O."Annual_Income"=c.annual_income)
	INNER JOIN transmission_table t
	ON(O."Transmission"=t.transmission)
	INNER JOIN dealer_table d
	ON(O.dealer_number=d.dealer_number and O."Dealer_Region"=d.dealer_region)
	INNER JOIN model_table m
	ON(O."Company" = m.company and O."Model"=m.model and O."Body Style"=m.body_style)
)
SELECT DISTINCT
	car_id
	,sale_date
	,color
	,price
	,cust_id
	,model_id
	,trans_id
	,dealer_id
FROM cte_car_table 
WHERE n<2

--3. BUILDING TABLE: dealer_table
-- DROP TABLE IF EXISTS public.dealer_table;
CREATE TABLE IF NOT EXISTS public.dealer_table
(
    dealer_id SERIAL NOT NULL,
    dealer_name character varying(50) NOT NULL,
    dealer_number integer NOT NULL,
    dealer_region character varying(50),
    CONSTRAINT dealer_table_pkey PRIMARY KEY (dealer_id)
)
------Insert Data
INSERT INTO dealer_table(dealer_name,dealer_number,dealer_region)
SELECT DISTINCT
	"Dealer_Name"
	,dealer_number
	,"Dealer_Region"
FROM public.dirty_sales_data


--4. BUILDING TABLE: customer_table
-- DROP TABLE IF EXISTS public.customer_table;
CREATE TABLE IF NOT EXISTS public.customer_table
(
    cust_id SERIAL NOT NULL,
    customer_name character varying(100) NOT NULL,
    gender character varying(100) NOT NULL,
    annual_income numeric NOT NULL,
    phone integer NOT NULL,
    CONSTRAINT customer_table_pkey PRIMARY KEY (cust_id)
)
------Insert Data
INSERT INTO customer_table(customer_name,gender,annual_income,phone)
SELECT DISTINCT
	"Customer_Name"
	,"Gender"
	,"Annual_Income"
	,"Phone"
FROM dirty_sales_data

--5. BUILDING TABLE: model_table
-- DROP TABLE IF EXISTS public.model_table;
CREATE TABLE IF NOT EXISTS public.model_table
(
    model_id SERIAL NOT NULL,
    company character varying(100) NOT NULL,
    model character varying(100) NOT NULL,
    body_style character varying(100) NOT NULL,
    CONSTRAINT model_table_pkey PRIMARY KEY (model_id)
)
------Insert Data
INSERT INTO model_table(company,model,body_style)
SELECT DISTINCT
	"Company"
	,"Model"
	,"Body Style"
FROM dirty_sales_data
ORDER BY 1

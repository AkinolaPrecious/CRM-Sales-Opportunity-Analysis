--SALESPIPELINE TABLE
UPDATE salespipeline
SET sales_agent = TRIM([sales_agent]) 

UPDATE salespipeline
SET product = TRIM(product) 

UPDATE salespipeline
SET deal_stage = TRIM(deal_stage) 

UPDATE salespipeline
SET account = TRIM(account)

--ACCOUNTS TABLE
UPDATE accounts
SET account = TRIM(account)

UPDATE accounts
SET sector = TRIM(sector)

UPDATE accounts
SET office_location = TRIM(office_location)

UPDATE accounts
SET subsidiary_of = TRIM(subsidiary_of)

--DATA TYPES
ALTER TABLE accounts
ALTER COLUMN year_established int

ALTER TABLE sales_pipeline
ALTER COLUMN account nvarchar(50)not null

ALTER TABLE products
ALTER COLUMN sales_price FLOAT

ALTER TABLE sales_pipeline
ALTER COLUMN close_value FLOAT

UPDATE accounts
SET sector = 'technology'
WHERE sector = 'technolgy'

UPDATE salespipeline
SET product = 'GTX Pro'
WHERE product = 'GTXPro'



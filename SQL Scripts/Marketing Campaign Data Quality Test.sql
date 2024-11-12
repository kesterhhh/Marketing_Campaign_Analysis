/*

DATA QUALITY TESTS

1. The dataset should contain a specific number of records (row count test)
2. The dataset should have a specific number of columns (column count test)
3. Each column should have the correct data type (data type check)
4. CTR values should be within the valid range of 0 to 1 (range check)
5. Latitude and longitude values should be within valid ranges (range check)

Summary of Expected Requirements:
- Row count: 9900
- Column count: 18
- Data types:
	- Season = Varchar
	- Date = Date
	- City = Varchar
	- Latitude = Float
	- Longitude = Float
	- Channel = Varchar
	- Device = Varchar
	- Ad = Varchar
	- Impressions = Float
	- CTR = Decimal
	- Clicks = Tinyint
	- Daily_Average_CPC = Decimal
	- Spend = Int
	- Conversions = Tinyint
	- Total_Conversion_Value = Decimal
	- Likes = Tinyint
	- Shares = Tinyint
	- Comments = Tinyint

*/


-- Step 1: Row count check
SELECT COUNT(*) AS Total_Rows FROM view_marketing_campaign_dataset;

-- Step 2: Column count check
SELECT COUNT(*) AS Total_Columns
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'view_marketing_campaign_dataset';

-- Step 3: Data type check
SELECT 
  COLUMN_NAME,
  DATA_TYPE
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'view_marketing_campaign_dataset';

-- Step 4: Range checks for CTR %
SELECT 
    COUNT(*) AS Invalid_CTR_Count
FROM 
    view_marketing_campaign_dataset
WHERE 
    CTR < 0 OR CTR > 1;  -- Check for valid CTR values

-- Step 5: Check if latitude and longitude values are within valid ranges.
SELECT 
    COUNT(*) AS Total_Rows,
    SUM(CASE WHEN Latitude < -90 OR Latitude > 90 THEN 1 ELSE 0 END) AS Invalid_Latitude,
    SUM(CASE WHEN Longitude < -180 OR Longitude > 180 THEN 1 ELSE 0 END) AS Invalid_Longitude
FROM 
    view_marketing_campaign_dataset;
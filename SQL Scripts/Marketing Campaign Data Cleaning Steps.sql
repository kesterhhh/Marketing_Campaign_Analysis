/*Step 1: Let's clean the Marketing Campaign dataset by selecting relevant columns, formatting the date, and casting values to appropriate data types.
We'll store the cleaned data in a new table called Marketing_Campaign_Updated.*/

SELECT
    CAST(Campaign AS VARCHAR(50)) AS Season,
    Date,
    CAST("City_Location" AS VARCHAR(50)) AS City,
    Latitude,
    Longitude,
    CAST(Channel AS VARCHAR(50)) AS Channel,
    CAST(Device AS VARCHAR(50)) AS Device,
    CAST(Ad AS VARCHAR(50)) AS Ad,
    Impressions,
    CAST(REPLACE("CTR", '%', '') AS DECIMAL(5, 2)) / 100 AS CTR,
    Clicks,
    CAST(Daily_Average_CPC AS DECIMAL(18, 8)) AS Daily_Average_CPC,
    CAST("Spend_GBP" AS INTEGER) AS Spend,
    Conversions,
    CAST("Total_conversion_value_GBP" AS decimal(18,8)) AS Total_Conversion_Value,
    "Likes_Reactions" AS Likes,
    Shares,
    Comments
INTO Marketing_Campaign_Updated
FROM Marketing_Campaign_Dataset;

/*Step 2: We'll create a Common Table Expression (CTE) to analyze the cleaned dataset. 
This CTE will check for NULL values in each column and categorize the rows accordingly.*/

WITH CTE_Marketing_Campaign AS (
    SELECT *,
        CASE
            WHEN Season IS NULL OR 
                 Date IS NULL OR 
                 City IS NULL OR 
                 Latitude IS NULL OR 
                 Longitude IS NULL OR 
                 Channel IS NULL OR 
                 Device IS NULL OR 
                 Ad IS NULL OR 
                 Impressions IS NULL OR 
                 Clicks IS NULL OR 
                 Daily_Average_CPC IS NULL OR 
                 Spend IS NULL OR 
                 Conversions IS NULL OR 
                 Total_Conversion_Value IS NULL OR 
                 Likes IS NULL OR 
                 Shares IS NULL OR 
                 Comments IS NULL
            THEN 'Contains null values'
            ELSE 'No null values'
        END AS Contains_Null_Values
    FROM
        Marketing_Campaign_Updated
)
SELECT *  /*Step 3: Let's select all rows from the CTE where NULL values are present. This will help us identify any records that need further attention.*/
FROM CTE_Marketing_Campaign
WHERE Contains_Null_Values = 'Contains null values';

/*Step 4: Finally, we'll create a view named view_marketing_campaign_dataset to provide easy access to the cleaned dataset. 
This view will allow for simplified queries on the cleaned data.*/

CREATE VIEW view_marketing_campaign_dataset AS
SELECT
  *
FROM
  Marketing_Campaign_Updated;
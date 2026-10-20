/*
    Tables
*/

WITH source_data AS (
    SELECT * FROM {{ source('snapchat', 'snapchat_campaign') }}
),

/*
    Transformation
*/
cleaned AS (
    SELECT

            CAST(campaign_id AS STRING) AS campaign_id,
            CAST(account_id AS STRING) AS account_id,
            CAST(campaign_name AS STRING) AS campaign_name
    
    FROM source_data
)

SELECT * FROM cleaned
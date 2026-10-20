/*
    Tables
*/

WITH source_data AS(
    SELECT *
    FROM {{ source('snapchat', 'snapchat_adgroups')}}

),

/*
    Transformation
*/

cleaned AS(
    SELECT

        CAST(_surrogate_key AS STRING) AS surrogate_key,
        CAST(ad_group_id AS STRING) AS ad_group_id,
        CAST(campaign_id AS STRING) AS campaign_id,
        CAST(ad_group_name AS STRING) AS ad_group_name,
        CAST(ad_group_updated_at AS TIMESTAMP) AS ad_group_updated_at
    
    FROM source_data
)

SELECT * FROM cleaned
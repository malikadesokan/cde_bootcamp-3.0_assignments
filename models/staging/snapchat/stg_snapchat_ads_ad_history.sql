/*
    Tables
*/

WITH source_data AS (

    SELECT * 
    FROM {{ source('snapchat', 'snapchat_ads')}}
),

/*
    Transformation
*/

cleaned AS (

    SELECT

        CAST(ad_id AS STRING) AS ad_id,
        CAST(ad_group_id AS STRING) AS ad_group_id,
        CAST(ad_name AS STRING) AS ad_name,
        CAST(ad_detail_updated_at AS DATE) AS ad_updated_at

    FROM source_data

)

SELECT * FROM cleaned
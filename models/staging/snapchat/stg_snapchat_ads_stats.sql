{{
    config(
        event_time='ad_date',
    )
}}


/*
    Table
*/

WITH source_data AS (
    SELECT *
    FROM {{ source('snapchat', 'snapchat_ads_stats') }}
),

/*
    Transformation
*/

cleaned AS (

    SELECT
        CAST(ad_detail_id AS STRING) AS ad_id,
        CAST(ad_currency_code AS STRING) AS ad_currency_code,
        UPPER(CAST(ad_country AS STRING)) AS ad_country,
        CAST(ad_spend AS DOUBLE) AS ad_spend,
        TRY_CAST(ad_impressions AS INTEGER) AS ad_impressions,
        TRY_CAST(ad_clicks AS INTEGER) AS ad_clicks,
        CAST(ad_date AS DATE) AS ad_date,
        CAST(data_src AS STRING) AS data_src

    FROM source_data
)

SELECT * FROM cleaned
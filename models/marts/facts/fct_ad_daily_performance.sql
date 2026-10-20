{{
    config(
        materialized='table'
    )
}}

SELECT
    src_data,
    ad_id,
    ad_date,
    adgroup_id,
    campaign_id,
    currency_code,
    ad_spend,
    ad_impressions,
    ad_clicks

FROM {{ ref('int_ad_performance') }}
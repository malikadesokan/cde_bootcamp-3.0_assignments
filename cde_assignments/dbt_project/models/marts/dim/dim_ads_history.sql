

{{
    config(
        materialized='incremental',
        unique_key='ad_id',
        cluster_by=['src_data']
    )
}}

with snapchat as (
    select 
    'snapchat_ads' AS src_data,
    ad_id,
    ad_group_id,
    ad_name,
    ad_updated_at
    from {{ref('stg_snapchat_ads_ad_history')}}
),

facebook as (
    select 
    'facebook' AS src_data,
    ad_id,
    ad_group_id,
    ad_name,
    ad_updated_at
    from {{ref('stg_facebook_ads_ad_history')}}
)

select * from snapchat
union all
select * from facebook

with adgroups as (
        select * 
        from {{ ref('stg_snapchat_ad_adgroups_history')}}
        QUALIFY ROW_NUMBER() OVER(
        PARTITION BY ad_group_id
        ORDER BY ad_group_updated_at DESC
    ) = 1
),

ads as (

    select * 
    from {{ ref('stg_snapchat_ads_ad_history')}}
    QUALIFY ROW_NUMBER() OVER(
        PARTITION BY ad_id
        ORDER BY ad_updated_at DESC
    ) = 1
),

campaigns as (
    select *
    from {{ref('stg_snapchat_ad_campaigns_history')}}
),

ads_stats as(
    select *
    from {{ ref('stg_snapchat_ads_stats')}}
    QUALIFY ROW_NUMBER() OVER(
        PARTITION BY ad_id
        ORDER BY ad_date DESC
    ) = 1
),

final as (

select 
    ads_stats.ad_date AS ad_date,
    ads_stats.ad_id AS ad_id,
    ads.ad_name AS ad_name,
    adgroups.ad_group_id AS adgroup_id,
    adgroups.ad_group_name AS adgroup,
    campaigns.campaign_id AS campaign_id,
    campaigns.campaign_name AS campaign_name,
    ads_stats.ad_currency_code AS currency_code,
    ads_stats.ad_spend AS ad_spend,
    ads_stats.ad_impressions AS ad_impressions,
    ads_stats.ad_clicks AS ad_clicks,
    ads_stats.data_src AS src_data
from ads_stats
left join ads on ads_stats.ad_id = ads.ad_id
left join adgroups on ads.ad_group_id = adgroups.ad_group_id
left join campaigns on adgroups.campaign_id = campaigns.campaign_id

)

select * from final
order by ad_id, ad_date
with ads_stats as (
        select * 
        from {{ ref('stg_facebook_ads_basic_all_levels')}}
),

ads as (

    select * 
    from {{ ref('stg_facebook_ads_ad_history')}}
    QUALIFY ROW_NUMBER() OVER(
        PARTITION BY ad_id
        ORDER BY ad_updated_at DESC
    ) = 1
),

campaigns as (
    select *
    from {{ref('stg_facebook_ads_campaign_history')}}
    QUALIFY ROW_NUMBER() OVER(
        PARTITION BY campaign_id
        ORDER BY campaign_updated_at DESC
    ) = 1
),

accounts as(
    select *
    from {{ ref('stg_facebook_ads_account_history')}}
    QUALIFY ROW_NUMBER() OVER (
        PARTITION BY account_id
        ORDER BY account_updated_at DESC
    ) = 1
),

adgroups as(
    select * 
    from {{ref ('stg_facebook_ads_ad_set_history')}}
    QUALIFY ROW_NUMBER() OVER(
        PARTITION BY ad_group_id
        ORDER BY ad_group_updated_at DESC
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
    accounts.ad_currency_code AS currency_code,
    ads_stats.ad_spend AS ad_spend,
    ads_stats.ad_impressions AS ad_impressions,
    ads_stats.ad_clicks AS ad_clicks,
    'facebook' AS src_data
from ads_stats
left join ads on ads_stats.ad_id = ads.ad_id
left join campaigns on ads.campaign_id = campaigns.campaign_id
left join accounts on ads_stats.account_id = accounts.account_id
left join adgroups on ads.ad_group_id = adgroups.ad_group_id
)

select * from final
order by ad_id, ad_date
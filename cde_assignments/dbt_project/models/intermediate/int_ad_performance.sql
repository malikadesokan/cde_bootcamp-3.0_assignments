with facebook as (
    select * 
    from {{ref('int_fcb_ad_performance')}}
),

snapchat as (
     select * 
    from {{ref('int_snapchat_ad_performance')}}
)

select * from facebook
union all
select * from snapchat

order by ad_id, ad_date
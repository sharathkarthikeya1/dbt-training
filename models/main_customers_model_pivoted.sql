
with mc as (
select * from {{ ref('main_customers_model') }}

),

pivoted as (

    select 
        first_name,
        sum(case when nullvalues='include' then number_of_orders else 0 end) as include_amount,
        sum(case when nullvalues='exclude' then number_of_orders else 0 end) as exclude_amount

    from mc
    group by 1
)

select * from pivoted


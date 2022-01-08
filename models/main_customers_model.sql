{{
  config(
    materialized='table'
  )
}}

--CTE
with customers as( 
select * from {{ ref('stg_customers') }}
),

--CTE
customer_orders as( 
select * from {{ ref('stg_customerorders') }}
),

--CTE
data as (
select * from {{ ref('data') }}
),

--CTE
citiesdata as (
select city,country from {{ ref('cities_and_states') }}
),

--CTE:FINAL
final as(

select
        customers.customer_id,
        customers.first_name,
        customers.last_name,
        --fullnamecolumn
        -- concat first name and last name
          CONCAT(first_name, ',', left(last_name,1)) AS full_name,
        customer_orders.first_order_date,
        customer_orders.most_recent_order_date,
        --statecolumn
          case 
          when data.State is null then citiesdata.country else data.State end as state,
        data.city,
        citiesdata.country,
        --nullvaluescolumn
          case
        when first_order_date is null then "exclude"
        else "include"
        end as nullvalues,
        case
        when customer_orders.number_of_orders is null then 1 else customer_orders.number_of_orders end as number_of_orders
        
  
from customers
left join customer_orders using (customer_id)
left join data using (customer_id)
left join citiesdata using (city)
)

--filters
select * from final
where  city is not null
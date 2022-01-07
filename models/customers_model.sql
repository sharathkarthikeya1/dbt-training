  -- grabbing customers data

{{
  config(
    materialized='table'
  )
}}



with customers as( 
select * from {{ ref('stg_customers') }}
),

orders as( 
select * from {{ ref('stg_orders') }}
),

customer_orders as( 
select * from {{ ref('stg_customerorders') }}
),

final as(

select
        customers.customer_id,
        customers.first_name,
        customers.last_name,
        customer_orders.first_order_date,
        customer_orders.most_recent_order_date,
        customer_orders.number_of_orders

from customers
left join customer_orders using (customer_id)
)

select * from final
  
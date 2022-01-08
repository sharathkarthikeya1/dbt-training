with customers_orders AS (
  SELECT
    customer_id,
    MIN(order_date) AS first_order_date,
    MAX(order_date) AS most_recent_order_date,
    COUNT(order_id) AS number_of_orders,

  FROM
    {{ ref('stg_orders') }}
  GROUP BY
     customer_id 
)
select * from customers_orders


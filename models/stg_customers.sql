with customers as
(
SELECT
    id AS customer_id,
    first_name,
    last_name,
    from 
    `dbt-tutorial.jaffle_shop.customers` 
)
select * from customers
 
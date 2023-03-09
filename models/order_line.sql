{{config(materialized='table')}}

SELECT l.*,
s.id_store,
s.store_type
FROM {{ ref('stg_order_line') }} l
LEFT JOIN {{ ref('order_data') }} o USING (id_order)
LEFT JOIN {{ ref('store_data') }} s on o.id_store = s.id_store

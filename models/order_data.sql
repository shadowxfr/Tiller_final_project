{{config(materialized='table')}}

SELECT *,
IF (m_cached_price > m_cached_payed , 1 , 0) AS remise
FROM {{ ref('stg_order_data') }}
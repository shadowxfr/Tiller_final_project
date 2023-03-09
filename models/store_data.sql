{{config(materialized='table')}}

SELECT *
FROM {{ ref('stg_store_data') }}
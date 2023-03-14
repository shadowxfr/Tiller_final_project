{{config(materialized='table')}}

WITH col_categories AS (
SELECT
id_order,
id_store,
store_type,
m_total_price_inc_vat,
CASE
  WHEN categorie = "nourriture" THEN 1
  ELSE 0
END AS nourriture,
CASE
  WHEN categorie = "alcools" THEN 1
  ELSE 0
END AS alcools,
CASE
  WHEN categorie = "softs" THEN 1
  ELSE 0
END AS softs,
CASE
  WHEN categorie = "autres" THEN 1
  ELSE 0
END AS autres,
CASE
  WHEN categorie = "fleurs" THEN 1
  ELSE 0
END AS fleurs,
FROM {{ ref('stg_order_line') }})

SELECT
id_order,
max(id_store) AS id_store,
max(store_type) AS store_type,
max(nourriture) AS nourriture,
max(softs) AS softs,
max(alcools)AS alcools,
max(autres)AS autres,
max(fleurs)AS fleurs,
ROUND(SUM(m_total_price_inc_vat),2) AS turnover
FROM col_categories
GROUP BY id_order

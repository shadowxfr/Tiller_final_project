SELECT

--pk
EXTRACT(DATE FROM date_opened) AS date_date,
id_store,

--order
COUNT(id_order) AS nb_order,
SUM(m_nb_customer) AS nb_customer,

--turnover
ROUND(SUM(m_cached_payed),2) AS turnover,
ROUND(SUM(m_cached_payed)/COUNT(id_order),2) AS avg_turnover_per_order

FROM {{ ref('stg_order_data') }}

GROUP BY date_date, id_store
ORDER BY id_store, date_date
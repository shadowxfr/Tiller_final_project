{{config(materialized='table')}}

SELECT

## KEY ##
CAST(id_order AS STRING) AS id_order,
#########

-- id
CAST(id_store AS STRING) AS id_store,
CAST(id_table AS STRING) AS id_table,
CASE
  WHEN CAST(id_waiter AS STRING) IS NULL THEN "no_id"
  ELSE CAST(id_waiter AS STRING)
END AS id_waiter,
CASE
  WHEN CAST(id_device AS STRING) IS NULL THEN "no_id"
  ELSE CAST(id_device AS STRING)
END AS id_device,

-- dates
date_opened,
date_closed,

-- order
LOWER(dim_status) AS order_status,
CASE
  WHEN dim_source IS NULL THEN "autre"
  WHEN dim_source = "Tiller iPAD" THEN "tiller-ipad"
  WHEN dim_source = "Tiller iPod" THEN "tiller-ipod"
  ELSE LOWER(dim_source)
END AS dim_source,
m_nb_customer,
m_cached_payed,
m_cached_price

FROM `tiller-final-project.tiller.order_data`
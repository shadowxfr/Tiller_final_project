SELECT *,
EXTRACT(HOUR FROM date_opened) AS heure,
  DATE(date_opened) AS date_date,
  EXTRACT(YEAR FROM date_opened) AS annee,
  EXTRACT(DAYOFWEEK FROM date_opened) AS jour
FROM tiller-final-project.tiller_prod_staging.stg_order_data
  
-- Créer table avec order_id, id_table 
--(a emporter = 0, sur place = 1),
--catégorie des services 
    --[1(11h/15h), 2(15h01/18h00), 3(18h01/23h59), 4(24h/10h59)
-- ajouter colonne payment_type

-- order_id,
--id_table,
--date_date,
--jour,
--heure,
--annee,

SELECT
id_order,
id_store,
id_table,
EXTRACT(HOUR FROM date_opened) AS heure,
  DATE(date_opened) AS date_date,
  EXTRACT(YEAR FROM date_opened) AS annee,
  EXTRACT(DAYOFWEEK FROM date_opened) AS jour,
CASE 
  WHEN EXTRACT(HOUR FROM date_opened) BETWEEN 11 AND 14 THEN 1 
  WHEN EXTRACT(HOUR FROM date_opened) BETWEEN 15 AND 17 THEN 2 
  WHEN EXTRACT(HOUR FROM date_opened) BETWEEN 18 AND 23 THEN 3
  WHEN EXTRACT(HOUR FROM date_opened) BETWEEN 0 AND 10 THEN 4
  ELSE NULL
  END as services
FROM tiller-final-project.tiller_prod_staging.stg_order_data

-- pour payment type faire un left join de cette table + table 
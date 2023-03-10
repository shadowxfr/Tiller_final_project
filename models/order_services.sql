{{config(materialized='table')}}

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
o.id_order,
CASE
    WHEN p.id_pay IS NULL THEN "no_id"
    ELSE p.id_pay
END AS id_pay,
o.id_store,
o.id_table,
EXTRACT(HOUR FROM o.date_opened) AS hour_hour,
  DATE(o.date_opened) AS date_date,
  EXTRACT(YEAR FROM o.date_opened) AS year_year,
  EXTRACT(DAYOFWEEK FROM o.date_opened) AS day_day,
CASE
    WHEN p.payment_type in ("livraison", "uber eats", "deliveroo", "alloresto") then "livraison"
    ELSE "Sur Place"
END as Livraisonsurplace,
CASE 
    WHEN EXTRACT(HOUR FROM o.date_opened) BETWEEN 11 AND 14 THEN "2_midi"
    WHEN EXTRACT(HOUR FROM o.date_opened) BETWEEN 15 AND 17 THEN "3_après-midi"
    WHEN EXTRACT(HOUR FROM o.date_opened) BETWEEN 18 AND 23 THEN "4_soir"
    WHEN EXTRACT(HOUR FROM o.date_opened) BETWEEN 0 AND 10 THEN "1_matin"
    ELSE NULL
END as services, 
CASE
    WHEN p.payment_type IS NULL THEN "paiement_non_renseigne"
    ELSE p.payment_type
END AS payment_type,
p.m_amount

FROM {{ ref('stg_order_data') }} o 
LEFT JOIN {{ ref('stg_payment_data') }} p using (id_order)


-- pour payment type faire un left join de cette table + table
SELECT
-- pk
CAST(id_order_line AS STRING) AS id_order_line
,CAST(id_order AS STRING) AS id_order
-- dates
,date_opended AS date_opened
,date_created
-- conversion des gram en kg --
,IF (dim_unit_measure = "GRAM",m_quantity/1000,m_quantity) as m_quantity
,m_unit_price
,m_unit_price_exc_vat
,m_total_price_inc_vat
,m_total_price_exc_vat
-- 2 chiffres après la virgule
,ROUND(m_tax_percent,2) AS m_tax_percent
,ROUND(m_discount_amount,2) AS m_discount_amount
-- minuscule et remplacement des espaces par underscore
,LOWER (dim_type) AS order_line_type
,LOWER (REPLACE (dim_category, " ", "_")) AS dim_category
,LOWER (REPLACE (dim_name, " ", "_")) AS dim_name
,LOWER (REPLACE (dim_feature_type, " ", "_")) AS dim_feature_type
-- modification de la catégorie GRAM en KILOGRAM 
,CASE
  WHEN REGEXP_CONTAINS(LOWER(dim_unit_measure), "kilogram") THEN "kilogram"
  WHEN (LOWER(dim_unit_measure)= "gram") THEN "kilogram"
  ELSE "unit"
END AS dim_unit_measure
FROM `tiller-final-project.tiller.order_line` 
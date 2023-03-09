{{config(materialized='table')}}

SELECT
CAST(id_store AS STRING) AS id_store,
CASE
    WHEN (id_store) = 7872 THEN "Bar à Chicha"
    WHEN (id_store) = 4151 THEN "Bar à jeux"
    WHEN (id_store) = 351 THEN "Brasserie"
    WHEN (id_store) = 2035 THEN "Brasserie"
    WHEN (id_store) = 5210 THEN "Brasserie"
    WHEN (id_store) = 4803 THEN "Café restaurant"
    WHEN (id_store) = 4364 THEN "Café restaurant"
    WHEN (id_store) = 5860 THEN "Café restaurant"
    WHEN (id_store) = 5617 THEN "Café spectacle"
    WHEN (id_store) = 6008 THEN "Fleuriste"
    WHEN (id_store) = 6830 THEN "Indien"
    WHEN (id_store) = 730 THEN "Indien"
    WHEN (id_store) = 1513 THEN "Indien"
    WHEN (id_store) = 360 THEN "Italien"
    WHEN (id_store) = 6827 THEN "Italien"
    WHEN (id_store) = 8291 THEN "Restaurant"
    WHEN (id_store) = 7304 THEN "Restaurant"
    WHEN (id_store) = 5498 THEN "Restaurant"
    WHEN (id_store) = 4196 THEN "Restaurant"
    WHEN (id_store) = 5281 THEN "Salon de thé"
    WHEN (id_store) = 7786 THEN "Torréfacteur"
    ELSE "non défini"
END AS store_type,
date_created,
dim_zipcode,
dim_country,
dim_currency
FROM `tiller-final-project.tiller.store_data`
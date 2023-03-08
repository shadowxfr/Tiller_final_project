{{config(materialized='table')}}

SELECT
CAST(id_pay AS STRING) AS id_pay,
CAST(id_order AS STRING) AS id_order,
m_amount,
date_created,
CASE
    WHEN lower(dim_type) = "carte_ticket_restaurant" 
    OR lower(dim_type) = "carte ticket restaurant" 
    OR lower(dim_type) = "cb_ticket_resto"
    THEN "ticket_restaurant_carte"
    ELSE lower(dim_type)
END AS payment_type
FROM `tiller-final-project.tiller.payment_data`;


--Checked primary key unicity and not null values.
--Removed "dim_status" column because all values are equal to "accepted".
--Removed "m_cashback" and "m_credit" columns because all values are equal to "0" or NUll.
--Renamed "dim_type" column to differentiate from the one in table "order_line".
--Casted id columns in string format.
--Uniformized "payment_type" different values.
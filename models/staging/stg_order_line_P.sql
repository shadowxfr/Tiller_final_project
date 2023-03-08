SELECT

-- Arrondir les prix
round(m_unit_price,2) as m_unit_price,
round(m_unit_price_exc_vat,2) as m_unit_price_exc_vat,
round(m_total_price_inc_vat,2) as m_total_price_inc_vat,
round(m_total_price_exc_vat,2) as m_total_price_exc_vat,

FROM `tiller-final-project.tiller.order_line`


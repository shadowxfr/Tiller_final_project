{{config(materialized='table')}}

SELECT
-- pk
CAST(id_order_line AS STRING) AS id_order_line,
CAST(id_order AS STRING) AS id_order,
-- dates
date_opended AS date_opened,
date_created,
-- conversion des gram en kg --
IF (dim_unit_measure = "GRAM",m_quantity/1000,m_quantity) as m_quantity,
-- Arrondir les prix
round(m_unit_price,2) as m_unit_price,
round(m_unit_price_exc_vat,2) as m_unit_price_exc_vat,
round(m_total_price_inc_vat,2) as m_total_price_inc_vat,
round(m_total_price_exc_vat,2) as m_total_price_exc_vat,
-- 2 chiffres après la virgule
ROUND(m_tax_percent,2) AS m_tax_percent,
ROUND(m_discount_amount,2) AS m_discount_amount,
-- minuscule et remplacement des espaces par underscore
LOWER (dim_type) AS order_line_type,
LOWER (REPLACE (dim_category, " ", "_")) AS dim_category,
LOWER (REPLACE (dim_name, " ", "_")) AS dim_name,
LOWER (REPLACE (dim_feature_type, " ", "_")) AS dim_feature_type,
-- modification de la catégorie GRAM en KILOGRAM 
CASE
  WHEN REGEXP_CONTAINS(LOWER(dim_unit_measure), "kilogram") THEN "kilogram"
  WHEN (LOWER(dim_unit_measure)= "gram") THEN "kilogram"
  ELSE "unit"
END AS dim_unit_measure,

CASE 
WHEN lower(dim_category) IN ("ae les alcools"
, "ae autres boissons"
, "ae boissons chaudes"
, "ae boissons fraiches"
, "a emporter"
, "alcool"
, "alcool salle"
, "alcool sup"
, "alcools (4cl)"
, "alcools et apéros"
, "alcools forts"
, "alsace pinot noir"
, "alsace riesling"
, "anjou chenin"
, "aperitifs"
, "apéritifs"
, "apéro"
, "aperitifs \u0026 spiritueux"
, "aperitivo"
, "autres spécialités tasse"
, "autres spƒcialitƒs chaudes"
, "autres spƒecialites chaudes"
, "bar / aperitif"
, "bar / bieres"
, "bar / boissons chaudes"
, "bar / boissons froides"
, "bar / vin"
, "beers"
, "bière epicerie"
, "bières"
, "blanc bouteille"
, "blanc verre"
, "biere bio"
, "bieres"
, "bieres \u0026 cidres bouteilles"
, "bieres bouteilles"
, "bieres pression"
, "bieres pressions"
, "boisson alcoolisée"
, "boisson alcoolisées"
, "boissons"
, "boissons chaudes"
, "boissons fraiches"
, "boissons fraîches"
, "boissons gazeuses"
, "boissons indiennes"
, "boissons resto"
, "boissons sans alcool"
, "boissons vae"
, "boissons ☕️"
, "bordeaux rouges a.o.p"
, "bordeaux supérieur goélane"
, "bourgueil le plessis"
, "brouilly"
, "buzet merlot"
, "cafe"
, "cafe / the"
, "cafe, the \u0026 chocolat"
, "cafeterie"
, "cafetières"
, "cafetières italienne"
, "café au kilo"
, "café au vrac !"
, "café sachet"
, "café sachet 250 g"
, "café toref"
, "café vert"
, "cafés"
, "cafés en grain"
, "castel del monte"
, "cave"
, "champagne"
, "champagne "
, "cidre appie"
, "cidres"
, "cidres/bières"
, "cocktail"
, "cocktails"
, "côtes de provence"
, "côtes du rhône"
, "delamotte"
, "digestifs"
, "digestifs 2 cl"
, "drinks"
, "drinks lunch"
, "dégustation / visite"
, "dégustation de 3 crus"
, "džgustation de 3 crus"
, "eau minerale"
, "eaux"
, "happy hour"
, "happy hour cocktails"
, "i.g.p côtes du tarn"
, "les vins blancs"
, "long drink"
, "martini"
, "martini 15 cl"
, "jus de fruit"
, "jus de fruits"
, "jus et nectar zenat"
, "kir 15 cl"
, "lassi"
, "lassi 40 cl"
, "laurent-perrier"
, "le clos"
, "les alcools"
, "les eaux"
, "muscadet sur lie"
, "médoc château"
, "nos aperitifs"
, "nos bieres"
, "nos boissons chaudes"
, "nos champagnes"
, "nos cocktails"
, "nos eaux minerales"
, "petillant nature"
, "petillants"
, "pression"
, "roiboos glace bos"
, "rooibos glace bos"
, "rose bouteille"
, "rose verre"
, "rouge bouteille"
, "rouge verre"
, "salle / aperitifs"
, "salle / bieres"
, "salle / boissons chaudes"
, "salle / boissons froides"
, "salle / vin"
, "san pellegrino"
, "soda et jus de fruits"
, "soft"
, "soft epicerie"
, "soft à emporter"
, "softs"
, "the"
, "thé"
, "thé/cafe"
, "touraine gamay"
, "valle d\u0027oro"
, "valpolicella"
, "vin"
, "vin au verre"
, "vin au verre 14 cl"
, "vin blanc"
, "vin blancs"
, "vin indien"
, "vin pichet"
, "vin rosé"
, "vin rosés"
, "vin rouge"
, "vin rouges"
, "vin verre"
, "vins"
, "vins \u0026 champagnes"
, "vins 37.5cl"
, "vins 75cl"
, "vins blancs"
, "vins blancs 25cl"
, "vins blancs 50cl"
, "vins blancs a.o.p"
, "vins blancs bouteille"
, "vins blancs verre"
, "vins blancs/rosés"
, "vins bouteille"
, "vins bt"
, "vins d-vine"
, "vins en bouteille"
, "vins et alcools"
, "vins indiens"
, "vins pichet"
, "vins roses"
, "vins roses a.o.p"
, "vins rosés 25cl"
, "vins rosés 50cl"
, "vins rosés bouteille"
, "vins rosés verre"
, "vins rouges"
, "vins rouges 25cl"
, "vins rouges 50cl"
, "vins rouges a.o.p"
, "vins rouges bouteille"
, "vins rouges verre"
, "vins verre et carafe"
, "vins verres"
, "vins à emporter"
, "whisky 5 cl"
, "whiskys"
, "ae en version glacee"
, "ae espressions"
, "ae espressions "
, "ae moccamaster drip"
, "instantané"
, "charitea-mate"
, "evian"
, "expressions espresso"
, "☕️"
, "soiree privée"
, "saumur"
, "saumur champigny"
, "sélection 125g"
, "sélection 1kg"
, "sélection 250g" 
, "sirop"
, "selection 125g"
, "selection 1kg"
, "selection 250g"
, "carte des vins"
, "chaud")
THEN "boissons"
WHEN lower(dim_category) IN ("add"
, "accompagnements"
, "ae les sucres"
, "ae les sucrés"
, "antipasti"
, "avocado toast"
, "condiments"
, "confiserie"
, "contorni"
, "coursemeal"
, "cuisson"
, "cuissons"
, "brunch"
, "carte"
, "carte du midi"
, "carte du soir"
, "carte midi"
, "weekly bowl"
, "biriyani"
, "bocaux repas"
, "bowl"
, "bowls de saison"
, "breizh\u0027n\u0027roll"
, "charcuterie"
, "chocolat plaq"
, "choix de la formule"
, "choix parfum"
, "choix vegetarien nord"
, "choix vegetarien nord 1"
, "choix vegetarien sud"
, "choix vegetarien sud 1"
, "dessert"
, "dessert maison"
, "desserts"
, "desserts a e"
, "desserts sur place"
, "desserts vae"
, "desserts à emporter"
, "dinner menu"
, "déjeuner"
, "dîner"
, "entrees"
, "entrees emp"
, "entrees formule"
, "entretien"
, "entrée tibétaines"
, "entrées"
, "entrées  tandoori"
, "entrées / soupes / salades"
, "entrées spécialités tandoor"
, "entées"
, "envies salées"
, "envies salƒes"
, "epicerie"
, "focaccia a emporter"
, "focaccia sur place"
, "formule"
, "formule dejeuner"
, "formule déjeuner"
, "formule entrée plat"
, "formule livraison"
, "formule plat dessert"
, "formules"
, "formules du jour"
, "frawmages"
, "fromages"
, "glaces et sorbets"
, "gout glace"
, "légumes"
, "menu"
, "menu 16,50"
, "menu 25,00"
, "menu découverte"
, "menu dégustation"
, "menu enfant"
, "menu express"
, "menu midi"
, "menu saint sylvestre"
, "menu soir"
, "menus"
, "menus à emporter"
, "midi"
, "mix entrée sagarmatha"
, "mix grill"
, "pain"
, "pains"
, "panna cotta"
, "parfum"
, "parfums coulis"
, "parfums glaces"
, "parfums sorbets"
, "pasta a emporter"
, "pasta fresca emporter"
, "pasta sur place"
, "patisserie"
, "patisseries"
, "pdj"
, "petit dej"
, "petit déjeuner"
, "petit-déjeuner 8h30 / 11h30"
, "petit-džjeuner 8h30 / 11h30"
, "petite épicerie"
, "pizza"
, "planche"
, "planches"
, "plat"
, "plat du jour"
, "plat formule"
, "plat traditionnel népalais"
, "plats"
, "plats / agneau"
, "plats / poulet"
, "plats chauds"
, "plats du jour comptoir"
, "plats du jour vitrine"
, "plats nord"
, "plats sud"
, "plats tibétaines"
, "plats vae"
, "plats vegetarien"
, "poisson - crevettes - gambas"
, "riz"
, "royal biryani"
, "salades"
, "salades vae"
, "sandwiches"
, "sandwichs"
, "sandwichs vae"
, "sorbets / glace"
, "soupe"
, "soupe \u0026 bouillon"
, "soupe \u0026 bouillon vae"
, "soupe et ramen"
, "sourie dagneau"
, "spokbowl"
, "spécialités tibétaines entrée"
, "spécialités tibétaines plats"
, "in-salades a emporter"
, "in-salades sur place"
, "traiteur"
, "tapas"
, "vegan"
, "supplement"
, "supplements"
, "suppléments"
, "wrap de sarrasin"
, "repas"
, "terre"
, "snacks sucres"
, "sides"
, "les sucres"
, "les sucrés")
THEN "nourriture"
WHEN lower(dim_category) IN ("vente directe", "interflora") 
THEN "fleurs"
ELSE "autres"
END AS categorie

FROM `tiller-final-project.tiller.order_line` 

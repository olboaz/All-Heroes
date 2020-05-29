require 'json'
require 'open-uri'
require 'faker'

data_url = "https://data.iledefrance.fr/api/records/1.0/search/?dataset=adresses_et_donnees_gps_des_bibliotheques_municipales&q=&rows=700&facet=new_name&facet=nom_dept&facet=comment&facet=type_adresse"
  data_serialized = open(data_url).read
  data = JSON.parse(data_serialized)

p data['records'][1]['geometry']['coordinates'][0]

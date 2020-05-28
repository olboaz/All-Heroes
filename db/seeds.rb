# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

puts "suppression des tables"
Heroe.destroy_all
Publisher.destroy_all
User.destroy_all

require 'json'
require 'open-uri'
require 'faker'

# Paris Data
# https://opendata.paris.fr/api/records/1.0/search/?dataset=restaurants-casvp&facet=code&facet=nom_restaurant&facet=type

User1 = User.new(email: "toto@free.fr", username:"toto", password: "123456")
User1.save

my_api_key = ENV['HERO_API_KEY']
marvel_api_key = ENV['MARVEL_PUBLIC']
marvel_hash = ENV['MARVEL_HASH']

puts "ajouts des datas"
[*1..22, *24..30].each { |i|
  puts "----Enregistrement #{i}----"

  url = "https://superheroapi.com/api/#{my_api_key}/#{i}"
  hero_serialized = open(url).read
  hero = JSON.parse(hero_serialized)

  data_url = "https://opendata.paris.fr/api/records/1.0/search/?dataset=restaurants-casvp&rows=45&facet=code&facet=nom_restaurant&facet=type"
  data_serialized = open(data_url).read
  data = JSON.parse(data_serialized)

  puts "Nom : #{hero['name']}"
  marvel_url ="https://gateway.marvel.com:443/v1/public/characters?nameStartsWith=#{hero['name']}&apikey=#{marvel_api_key}&ts=1&hash=#{marvel_hash}"
  marvel_serialized = open(marvel_url).read
  marvel = JSON.parse(marvel_serialized)

  puts "test description marvel #{i}"
  if marvel['data']['results'].empty? || marvel['data']['results'][0]['description'].empty?
    desc = "unknown"
  else
    desc = marvel['data']['results'][0]['description']
  end

  puts "test lat & long #{i}"
  if data['records'][i]['fields']['tt'].nil?
    lat = 48.8525
    long = 2.3048
  else
    lat = data['records'][i]['fields']['tt'][0]
    long = data['records'][i]['fields']['tt'][1]
  end

  puts "test publisher #{i}"
  if hero['biography']['publisher'].nil?
    publisher = Publisher.new(name: "Others")
  else
    publisher = Publisher.new(name: hero['biography']['publisher'])
  end
  publisher.save!

  puts "Creation du heros #{i}"
  heroe = Heroe.new(
    name: hero['name'],
    description: desc,
    address: Faker::Address.full_address,
    image_hero: hero['image']['url'],
    height: hero['appearance']['height'][1],
    weight: hero['appearance']['weight'][1],
    gender: hero['appearance']['gender'],
    race: hero['appearance']['race'],
    aliases: hero['biography']['aliases'][1],
    intelligence: hero['powerstats']['intelligence'],
    strength: hero['powerstats']['strength'],
    speed: hero['powerstats']['speed'],
    durability: hero['powerstats']['durability'],
    power: hero['powerstats']['power'],
    combat: hero['powerstats']['combat'],
    latitude: lat, # Faker::Address.latitude,
    longitude: long, #Faker::Address.longitude,
    publisher_id: Publisher.last.id,
    user_id: User.first.id
  )
  heroe.save!
  puts "Héros #{i} sauvegardé !"
  puts ""
}

puts 'Finished !'

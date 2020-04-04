# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


Heroe.destroy_all


require 'json'
require 'open-uri'
require 'faker'

my_api_key = ENV['HERO_API_KEY']

(1..50).each { |i|
url = "https://superheroapi.com/api/#{my_api_key}/#{i}"
hero_serialized = open(url).read
hero = JSON.parse(hero_serialized)

publisher = Publisher.new(name: hero['biography']['publisher'])
publisher.save!

heroe = Heroe.new(
  name: hero['name'],
  description: hero['name'],
  address: Faker::Address.full_address,
  image_hero: hero['image']['url'],
  height: hero['appearance']['height'][1],
  weight: hero['appearance']['weight'][1],
  latitude: Faker::Address.latitude,
  longitude: Faker::Address.longitude,
  publisher_id: i
)
heroe.save!
}


# puts 'Creating 10 fake heroes...'
# 10.times do
#   heroe = Heroe.new(
#     name:    Faker::Superhero.name,
#     address: Faker::Address.full_address,
#     latitude: Faker::Address.latitude,
#     longitude: Faker::Address.longitude
#   )
#   heroe.save!
# end
puts 'Finished!'

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


Product.create!(
    :name             => "The old church on the coast of White sea",
    :description      => "Sergey Ershov",
    :price_in_cents   => "50"
)

Product.create!(
    :name             => "Sea Power",
    :description      => "Stephen Scullion",
    :price_in_cents   => "500"
)

Product.create!(
    :name             => "Into the Poppies",
    :description      => "John Wilhelm",
    :price_in_cents   => "50000"
)


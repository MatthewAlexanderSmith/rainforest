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

Product.create!(
    :name             => "Nalgene Water Bottle",
    :description      => "Made in USA",
    :price_in_cents   => "20"
)

Product.create!(
    :name             => "Mac Book Pro 15in 2015",
    :description      => "Sweet Laptop",
    :price_in_cents   => "4500"
)

Product.create!(
    :name             => "Samsung S3",
    :description      => "Phone that works",
    :price_in_cents   => "200"
)

100.times do |i|

Product.create({
  name: "Product#{i}",
  description: "Description#{i}",
  price_in_cents: i
  }
)
end

Category.create!(
    :name             => "Books"

)

Category.create!(
    :name             => "Electronics"

)

Category.create!(
    :name             => "Instruments"

)

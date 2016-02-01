class Product < ActiveRecord::Base
  validates :name, :description, presence: true
  validates :price_in_cents, numericality: {only_integer: true}

  has_many :reviews, dependent: :destroy
  has_many :users, through: :reviews

  def formatted_price
    price_in_dollars = price_in_cents / 100.0
    # sprintf("%.2f", price_in_dollars)
  end
end

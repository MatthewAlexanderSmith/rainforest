class User < ActiveRecord::Base
  has_secure_password

  has_many :reviews, dependent: :destroy
  has_many :products, through: :reviews

  # validates :first_name, presence: true

end

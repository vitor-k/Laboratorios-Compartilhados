class Admin < ApplicationRecord

  has_many :postagems, dependent: :destroy
  has_many :pedidos, dependent: :destroy
  
end

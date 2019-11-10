class Admin < ApplicationRecord

  has_one :user, as: :meta, dependent: :destroy
  accepts_nested_attributes_for :user

  has_many :postagems, dependent: :destroy
  has_many :pedidos, dependent: :destroy
  
end

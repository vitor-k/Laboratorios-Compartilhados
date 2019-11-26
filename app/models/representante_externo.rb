class RepresentanteExterno < ApplicationRecord

  has_one :user, as: :meta, dependent: :destroy
  accepts_nested_attributes_for :user
  
  validates :RG, presence: true, uniqueness: true
  validates :UF, presence: true
end

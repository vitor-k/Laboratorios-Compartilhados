class Docente < ApplicationRecord

  has_one :user, as: :meta, dependent: :destroy
  accepts_nested_attributes_for :user

  has_many :postagems, dependent: :destroy
  has_many :pedidos, dependent: :destroy
  has_many :laboratorios, class_name: 'Laboratorio', foreign_key: 'responsavel_id' 
  
  validates :nusp, presence: true
  validates :departamento, presence: true
  validates :nusp, numericality: { only_integer: true }
end

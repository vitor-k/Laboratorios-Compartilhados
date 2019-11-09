class Docente < ApplicationRecord

  has_many :postagems, dependent: :destroy
  has_many :pedidos, dependent: :destroy
  has_many :laboratorios, class_name: 'Laboratorio', foreign_key: 'responsavel_id' 
  
  validates :nome, presence: true
  validates :nusp, presence: true
  validates :departamento, presence: true
  validates :nusp, numericality: { only_integer: true }
end

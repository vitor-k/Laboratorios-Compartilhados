class Docente < ApplicationRecord
  belongs_to :usuario
  
  has_many :laboratorio_has_docente
  has_many :laboratorios, through: :laboratorio_has_docente
end

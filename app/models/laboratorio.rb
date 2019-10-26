class Laboratorio < ApplicationRecord
  has_many :postagems
  has_many :servicos
  has_many :alunos

  has_many :laboratorio_has_docentes
  has_many :docentes, through: :laboratorio_has_docentes
end

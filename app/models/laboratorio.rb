class Laboratorio < ApplicationRecord
  has_many :postagems
  has_many :servicos
  has_many :alunos
end

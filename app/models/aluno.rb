class Aluno < ApplicationRecord
  belongs_to :usuario
  belongs_to :laboratorio
end

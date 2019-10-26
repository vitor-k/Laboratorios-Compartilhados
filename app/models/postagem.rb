class Postagem < ApplicationRecord
  belongs_to :usuario
  belongs_to :laboratorio
end

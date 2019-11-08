class Equipamento < ApplicationRecord
    belongs_to :laboratorio
    belongs_to :pedido, dependent: :destroy
end

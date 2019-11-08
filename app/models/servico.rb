class Servico < ApplicationRecord
    belongs_to :laboratorio
    belongs_to :pedido
end

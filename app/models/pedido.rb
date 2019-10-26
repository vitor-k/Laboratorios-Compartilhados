class Pedido < ApplicationRecord
  belongs_to :usuario
  belongs_to :equipamento
  belongs_to :servico
end

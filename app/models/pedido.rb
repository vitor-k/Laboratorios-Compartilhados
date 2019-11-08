class Pedido < ApplicationRecord
    has_many :equipamentos
    has_many :recursos
    belongs_to :aluno
    belongs_to :representante_externo
    belongs_to :docente
end

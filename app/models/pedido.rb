class Pedido < ApplicationRecord
    belongs_to :equipamento, optional: true
    belongs_to :servico, optional: true
    belongs_to :aluno, optional: true
    belongs_to :representante_externo, optional: true
    belongs_to :docente, optional: true
end

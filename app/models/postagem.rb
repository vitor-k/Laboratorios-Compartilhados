class Postagem < ApplicationRecord
    belongs_to :aluno, optional: true
    belongs_to :admin, optional: true
    belongs_to :representante_externo, optional: true
    belongs_to :docente,  optional: true
    belongs_to :laboratorio, optional: true #retirar o optional depois
end

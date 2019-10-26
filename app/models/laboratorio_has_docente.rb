class LaboratorioHasDocente < ApplicationRecord
  belongs_to :laboratorio
  belongs_to :docente
end

class Laboratorio < ApplicationRecord
    has_many :equipamentos, dependent: :destroy
    has_many :servicos, dependent: :destroy
    has_many :postagems, dependent: :destroy
    has_many :alunos
    has_many :docentes
    
    # add responsavel
    
end

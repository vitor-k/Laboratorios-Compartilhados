class Laboratorio < ApplicationRecord
    has_many :equipamentos, dependent: :destroy
    has_many :servicos, dependent: :destroy
    has_many :postagems, dependent: :destroy
    has_many :alunos
    has_many :docentes

    belongs_to :responsavel, class_name: 'Docente', foreign_key: 'responsavel_id'  
    
    # add responsavel
    
end

class Laboratorio < ApplicationRecord
    attr_accessor :nUSP, :nomeCompleto
    attr_accessor :termo

    has_many :equipamentos, dependent: :destroy
    has_many :servicos, dependent: :destroy
    has_many :postagems, dependent: :destroy
    has_many :alunos
    has_many :docentes

    belongs_to :responsavel, class_name: 'Docente', foreign_key: 'responsavel_id', optional: true
    has_and_belongs_to_many :docentes
    
    # add responsavel
    
end

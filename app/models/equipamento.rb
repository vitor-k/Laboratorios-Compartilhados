class Equipamento < ApplicationRecord
    belongs_to :laboratorio
    has_many :pedidos, dependent: :destroy

    validate :existe
    validates :nome, presence: true
    validates :funcao, presence: true
    validates :taxa, presence: true, numericality: { only_decimal: true }

    def existe
        self.errors.add(:nome, 'já existe.') if (Equipamento.where(nome: self.nome, laboratorio_id: self.laboratorio_id).exists?)
    end
end

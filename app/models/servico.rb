class Servico < ApplicationRecord
    belongs_to :laboratorio
    has_many :pedidos, dependent: :destroy

    validate :existe
    validates :nome, presence: true
    validates :descricao, presence: true
    validates :taxa, presence: true
    validates :taxa, presence: true, numericality: { only_decimal: true }

    def existe
        if (self.id == nil)
            self.errors.add(:nome, 'já existe.') if Equipamento.where("nome == ? AND laboratorio_id == ?", self.nome, self.laboratorio_id).any?
        else
            self.errors.add(:nome, 'já existe.') if Equipamento.where("nome == ? AND laboratorio_id == ? AND id != ?", self.nome, self.laboratorio_id, self.id).any?
        end
    end

end

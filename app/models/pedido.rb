class Pedido < ApplicationRecord
    belongs_to :equipamento, optional: true
    belongs_to :servico, optional: true
    belongs_to :user, optional: false

    validates :descricao, presence: true

    validate :dates_in_order
    validate :date_before_time
    validate :em_horario_aceito
    # validate :checa_serv_equip

    def dates_in_order
        self.errors.add(:data_inicio, "deve ser antes do fim da data") unless self.data_inicio < self.data_fim
    end

    def date_before_time
        self.errors.add(:data_inicio, "deve ser depois do dia atual") unless data_inicio.beginning_of_day > Date.today.beginning_of_day
    end

    def em_horario_aceito
        if (self.id == nil)
            self.errors.add(:data_inicio, "deve ser em uma data não pega") if Pedido.where("(NOT ((data_inicio > ?) OR (data_fim < ?))) AND (aceito = ?) AND (equipamento_id = ? OR servico_id = ?)", self.data_fim, self.data_inicio, true, self.equipamento_id, self.servico_id).any?
        else
            self.errors.add(:data_inicio, "deve ser em uma data não pega") if Pedido.where("(NOT ((data_inicio > ?) OR (data_fim < ?))) AND (aceito = ?) AND (equipamento_id = ? OR servico_id = ?) AND (id != ?)", self.data_fim, self.data_inicio, true, self.equipamento_id, self.servico_id, self.id).any?
        end
    end

end

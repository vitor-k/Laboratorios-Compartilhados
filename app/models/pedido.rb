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
        self.errors.add(:dataInicio, "deve ser antes do fim da data") unless self.dataInicio < self.dataFim
    end

    def date_before_time
        self.errors.add(:dataInicio, "deve ser depois do dia atual") unless dataInicio.beginning_of_day > Date.today.beginning_of_day
    end

    def em_horario_aceito
        if (self.id == nil)
            #puts Pedido.where("(NOT ((dataInicio > ?) OR (dataFim < ?))) AND (aceito = ?) AND (equipamento_id = ? OR servico_id = ?)", self.dataFim, self.dataInicio, true, self.equipamento_id, self.servico_id).count()
            self.errors.add(:dataInicio, "deve ser em uma data não pega") if Pedido.where("(NOT ((dataInicio > ?) OR (dataFim < ?))) AND (aceito = ?) AND (equipamento_id = ? OR servico_id = ?)", self.dataFim, self.dataInicio, true, self.equipamento_id, self.servico_id).any?
        else
            #puts Pedido.where("(NOT ((dataInicio > ?) OR (dataFim < ?))) AND (aceito = ?) AND (equipamento_id = ? OR servico_id = ?) AND (id != ?)", self.dataFim, self.dataInicio, true, self.equipamento_id, self.servico_id, self.id).count()
            self.errors.add(:dataInicio, "deve ser em uma data não pega") if Pedido.where("(NOT ((dataInicio > ?) OR (dataFim < ?))) AND (aceito = ?) AND (equipamento_id = ? OR servico_id = ?) AND (id != ?)", self.dataFim, self.dataInicio, true, self.equipamento_id, self.servico_id, self.id).any?
        end
    end

    #def checa_serv_equip
    #    if (equipamento_id==nil && servico_id==nil)
    #        self.errors.add(:equipamento, ": Deve ser escolhido pelo menos um equipamento ou serviço")
    #    elsif (equipamento_id!=nil && servico_id!=nil)
    #        self.errors.add(:equipamento, ": Deve ser escolhido um equipamento ou um serviço")
    #    end
    #end
end

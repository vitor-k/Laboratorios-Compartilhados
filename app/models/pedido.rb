class Pedido < ApplicationRecord
    belongs_to :equipamento, optional: true
    belongs_to :servico, optional: true
    belongs_to :user, optional: false

    validates :descricao, presence: true

    validate :dates_in_order
    validate :date_before_time
    validate :em_horario_aceito

    def dates_in_order
        errors.add(:dataInicio, "deve ser antes do fim da data") unless dataInicio < dataFim
    end

    def date_before_time
        errors.add(:dataInicio, "deve ser depois do dia atual") unless dataInicio.beginning_of_day > Date.today.beginning_of_day
    end

    def em_horario_aceito
        errors.add(:dataInicio, "deve ser em uma data não aceita") unless Pedido.where(descricao==" hbjnm")
    end
end

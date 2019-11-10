class CreatePedidos < ActiveRecord::Migration[5.2]
  def change
    create_table :pedidos do |t|
      t.datetime :dataInicio
      t.datetime :dataFim
      t.text :descricao
      
      t.belongs_to :equipamento
      t.belongs_to :servico
      t.belongs_to :aluno
      t.belongs_to :docente
      t.belongs_to :representante_externo_id

      t.timestamps
    end
  end
end

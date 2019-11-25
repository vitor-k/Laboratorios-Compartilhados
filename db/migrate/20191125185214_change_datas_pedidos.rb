class ChangeDatasPedidos < ActiveRecord::Migration[5.2]
  def change
    rename_column :pedidos, :dataInicio, :data_inicio
    rename_column :pedidos, :dataFim, :data_fim
  end
end

class AddLaboratorioIdToPedidos < ActiveRecord::Migration[5.2]
  def change
    add_column :pedidos, :laboratorio_id, :integer
  end
end

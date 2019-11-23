class AddAtivoToPedidos < ActiveRecord::Migration[5.2]
  def change
    add_column :pedidos, :aceito, :boolean
  end
end

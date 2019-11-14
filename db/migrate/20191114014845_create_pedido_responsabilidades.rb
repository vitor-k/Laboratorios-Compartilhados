class CreatePedidoResponsabilidades < ActiveRecord::Migration[5.2]
  def change
    create_table :pedido_responsabilidades do |t|
      t.integer :id_laboratorio
      t.integer :id_docente

      t.timestamps
    end
  end
end

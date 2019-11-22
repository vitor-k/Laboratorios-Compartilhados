class AddJustificativaToPedidoResponsabilidade < ActiveRecord::Migration[5.2]
  def change
    add_column :pedido_responsabilidades, :justificativa, :text
  end
end

class RemoveRepresentanteExternoIdFromPedidos < ActiveRecord::Migration[5.2]
  def change
    remove_reference :pedidos, :representante_externo_id, foreign_key: true
  end
end

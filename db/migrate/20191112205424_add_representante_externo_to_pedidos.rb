class AddRepresentanteExternoToPedidos < ActiveRecord::Migration[5.2]
  def change
    add_reference :pedidos, :representante_externo, foreign_key: true
  end
end

class CreatePedidos < ActiveRecord::Migration[5.2]
  def change
    create_table :pedidos do |t|
      t.datetime :dataInicio
      t.datetime :dataFim
      t.text :descricao

      t.timestamps
    end
  end
end

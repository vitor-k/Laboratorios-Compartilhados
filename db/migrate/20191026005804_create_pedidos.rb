class CreatePedidos < ActiveRecord::Migration[5.2]
  def change
    create_table :pedidos do |t|
      t.datetime :data
      t.text :descricao
      t.references :equipamento, foreign_key: true
      t.references :servico, foreign_key: true

      t.timestamps
    end
  end
end

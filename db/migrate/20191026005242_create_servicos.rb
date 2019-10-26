class CreateServicos < ActiveRecord::Migration[5.2]
  def change
    create_table :servicos do |t|
      t.string :nome
      t.text :funcao
      t.decimal :taxa
      t.references :laboratorio, foreign_key: true

      t.timestamps
    end
  end
end

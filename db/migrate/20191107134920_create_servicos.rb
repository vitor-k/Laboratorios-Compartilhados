class CreateServicos < ActiveRecord::Migration[5.2]
  def change
    create_table :servicos do |t|
      t.string :nome
      t.text :descricao
      t.decimal :taxa

      t.belongs_to :laboratorio
      
      t.timestamps
    end
  end
end

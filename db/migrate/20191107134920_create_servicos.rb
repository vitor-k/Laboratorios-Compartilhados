class CreateServicos < ActiveRecord::Migration[5.2]
  def change
    create_table :servicos do |t|
      t.text :nome
      t.text :descricao
      t.decimal :taxa

      t.timestamps
    end
  end
end

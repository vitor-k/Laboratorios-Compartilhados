class CreateEquipamentos < ActiveRecord::Migration[5.2]
  def change
    create_table :equipamentos do |t|
      t.text :nome
      t.text :funcao
      t.decimal :taxa

      t.timestamps
    end
  end
end

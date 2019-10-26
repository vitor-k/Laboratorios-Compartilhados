class CreateLaboratorios < ActiveRecord::Migration[5.2]
  def change
    create_table :laboratorios do |t|
      t.string :nome
      t.string :localizacao
      t.text :descricao

      t.timestamps
    end
  end
end

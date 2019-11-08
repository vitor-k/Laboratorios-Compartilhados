class CreateLaboratorios < ActiveRecord::Migration[5.2]
  def change
    create_table :laboratorios do |t|
      t.text :nome
      t.text :localizacao
      t.text :descricao

      t.timestamps
    end
  end
end

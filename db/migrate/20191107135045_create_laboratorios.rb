class CreateLaboratorios < ActiveRecord::Migration[5.2]
  def change
    create_table :laboratorios do |t|
      t.string :nome
      t.text :localizacao
      t.text :descricao

      t.timestamps
    end

    add_reference :laboratorios, :responsavel, foreign_key: true
  end
end
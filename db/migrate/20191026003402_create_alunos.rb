class CreateAlunos < ActiveRecord::Migration[5.2]
  def change
    create_table :alunos do |t|
      t.integer :nusp
      t.string :departamento
      t.references :usuario, foreign_key: true
      t.references :laboratorio, foreign_key: true

      t.timestamps
    end
  end
end

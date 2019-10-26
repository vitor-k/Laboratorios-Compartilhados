class CreateDocentes < ActiveRecord::Migration[5.2]
  def change
    create_table :docentes do |t|
      t.integer :nusp
      t.string :departamento
      t.references :usuario, foreign_key: true

      t.timestamps
    end
  end
end

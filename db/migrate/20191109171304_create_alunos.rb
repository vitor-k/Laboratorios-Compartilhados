class CreateAlunos < ActiveRecord::Migration[5.2]
  def change
    create_table :alunos do |t|
      t.integer :nusp
      t.string :departamento

      t.belongs_to :laboratorio

      t.timestamps
    end
  end
end

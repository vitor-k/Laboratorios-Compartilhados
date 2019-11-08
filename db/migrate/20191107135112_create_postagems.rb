class CreatePostagems < ActiveRecord::Migration[5.2]
  def change
    create_table :postagems do |t|
      t.text :texto
      t.integer :aluno_id
      t.integer :docente_id
      t.integer :representante_externo_id
      t.integer :admin_id
      t.integer :laboratorio_id      
      t.timestamps
    end
  end
end
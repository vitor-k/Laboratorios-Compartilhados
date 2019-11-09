class CreatePostagems < ActiveRecord::Migration[5.2]
  def change
    create_table :postagems do |t|
      t.text :texto

      t.belongs_to :aluno, optional: true
      t.belongs_to :admin, optional: true
      t.belongs_to :representante_externo, optional: true
      t.belongs_to :docente, optional: true
      t.belongs_to :laboratorio, optional: true

      t.timestamps
    end
  end
end
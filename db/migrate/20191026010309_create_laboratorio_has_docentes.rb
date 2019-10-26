class CreateLaboratorioHasDocentes < ActiveRecord::Migration[5.2]
  def change
    create_table :laboratorio_has_docentes do |t|
      t.references :laboratorio, foreign_key: true
      t.references :docente, foreign_key: true

      t.timestamps
    end
  end
end

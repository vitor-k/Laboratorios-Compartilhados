class CreateDocentesLaboratoriosJoinTable < ActiveRecord::Migration[5.2]
  def change
    create_join_table :laboratorios, :docentes
  end
end

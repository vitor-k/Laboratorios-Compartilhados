class RemoveDeviseFromModels < ActiveRecord::Migration[5.2]
  def change
      drop_table :alunos
      drop_table :docentes
      drop_table :admins
      drop_table :representante_externos
  end
end

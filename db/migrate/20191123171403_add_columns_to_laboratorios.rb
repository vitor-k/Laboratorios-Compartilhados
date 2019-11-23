class AddColumnsToLaboratorios < ActiveRecord::Migration[5.2]
  def change
    add_column :laboratorios, :numero_aceitos, :integer
    add_column :laboratorios, :numero_rejeitados, :integer
  end
end

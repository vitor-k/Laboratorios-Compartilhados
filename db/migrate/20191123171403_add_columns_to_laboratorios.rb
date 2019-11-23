class AddColumnsToLaboratorios < ActiveRecord::Migration[5.2]
  def change
    add_column :laboratorios, :numero_aceitos, :integer, default: 0
    add_column :laboratorios, :numero_rejeitados, :integer, default: 0
  end
end

class AddResponsavelToLaboratorios < ActiveRecord::Migration[5.2]
  def change
    add_reference :laboratorios, :responsavel, foreign_key: { to_table: :docentes }
  end
end

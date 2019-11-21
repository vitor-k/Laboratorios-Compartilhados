class RemoveUsersFromPedidos < ActiveRecord::Migration[5.2]
  def change
    remove_reference :pedidos, :aluno, foreign_key: true
    remove_reference :pedidos, :docente, foreign_key: true
    remove_reference :pedidos, :representante_externo, foreign_key: true
  end
end

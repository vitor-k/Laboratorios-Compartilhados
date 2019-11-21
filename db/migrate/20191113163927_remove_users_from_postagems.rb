class RemoveUsersFromPostagems < ActiveRecord::Migration[5.2]
  def change
    remove_reference :postagems, :aluno, foreign_key: true
    remove_reference :postagems, :docente, foreign_key: true
    remove_reference :postagems, :representante_externo, foreign_key: true
  end
end

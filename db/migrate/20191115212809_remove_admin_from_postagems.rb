class RemoveAdminFromPostagems < ActiveRecord::Migration[5.2]
  def change
    # remove_reference :postagems, :admin, foreign_key: true
  end
end

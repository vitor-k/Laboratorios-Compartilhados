class AddUserToPedidos < ActiveRecord::Migration[5.2]
  def change
    add_reference :pedidos, :user, foreign_key: true
  end
end

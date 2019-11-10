class AddNomeToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :nome, :string, default: "", null: false
  end
end

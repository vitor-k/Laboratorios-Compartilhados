class AddTituloToPostagems < ActiveRecord::Migration[5.2]
  def change
    add_column :postagems, :titulo, :string
  end
end

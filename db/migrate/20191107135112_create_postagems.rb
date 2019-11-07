class CreatePostagems < ActiveRecord::Migration[5.2]
  def change
    create_table :postagems do |t|
      t.text :texto

      t.timestamps
    end
  end
end

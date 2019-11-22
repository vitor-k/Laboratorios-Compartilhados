class CreatePostagems < ActiveRecord::Migration[5.2]
  def change
    create_table :postagems do |t|
      t.text :texto
      t.string :titulo

      t.belongs_to :user
      t.belongs_to :admin, optional: true
      t.belongs_to :laboratorio, optional: true

      t.timestamps
    end
  end
end

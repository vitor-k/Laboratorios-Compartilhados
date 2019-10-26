class CreateAdmins < ActiveRecord::Migration[5.2]
  def change
    create_table :admins do |t|
      t.integer :nusp
      t.references :usuario, foreign_key: true

      t.timestamps
    end
  end
end

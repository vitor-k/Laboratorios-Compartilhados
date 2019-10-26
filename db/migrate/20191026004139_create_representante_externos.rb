class CreateRepresentanteExternos < ActiveRecord::Migration[5.2]
  def change
    create_table :representante_externos do |t|
      t.integer :rg
      t.string :unidade
      t.references :usuario, foreign_key: true

      t.timestamps
    end
  end
end

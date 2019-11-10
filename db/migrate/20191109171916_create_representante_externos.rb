class CreateRepresentanteExternos < ActiveRecord::Migration[5.2]
  def change
    create_table :representante_externos do |t|
      t.integer :RG
      t.string :UF

      t.timestamps
    end
  end
end

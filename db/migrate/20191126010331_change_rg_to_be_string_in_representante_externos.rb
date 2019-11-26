class ChangeRgToBeStringInRepresentanteExternos < ActiveRecord::Migration[5.2]
  def change
    change_column :representante_externos, :RG, :string
  end
end

class ChangeRgToBeTextInRepresentanteExternos < ActiveRecord::Migration[5.2]
  def change
    change_column :Representante_externos, :RG, :text
  end
end

module LaboratoriosHelper
  def lab_has_postagem?
    Postagem.all.each do |postagem|
      if postagem.laboratorio_id == @laboratorio.id
        return true
      end
    end
    return false
  end
end

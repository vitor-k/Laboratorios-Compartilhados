module PagesHelper
  def has_postagem_from_admin?
    Postagem.all.each do |postagem|
      if postagem.laboratorio_id.nil? && User.find(postagem.user_id).meta_type == 'Admin'
        return true
      end
    end
    return false
  end
end
module ApplicationHelper
  # Garante compatibilidade com o código anterior
  def aluno_signed_in?
      user_signed_in? && current_user.aluno?
  end

  def docente_signed_in?
      user_signed_in? && current_user.docente?
  end

  def representante_externo_signed_in?
      user_signed_in? && current_user.representante_externo?
  end

  def admin_signed_in?
      user_signed_in? && current_user.admin?
  end

  def current_aluno
      Aluno.find(current_user.meta_id) if current_user.aluno?
  end

  def current_docente
      Docente.find(current_user.meta_id) if current_user.docente?
  end

  def current_representante_externo
      RepresentanteExterno.find(current_user.meta_id) if current_user.representante_externo?
  end

  def current_admin
      Admin.find(current_user.meta_id) if current_user.admin?
  end

  def edit_user_path
    if user_signed_in?
        if current_user.aluno?
            edit_aluno_path(Aluno.find(current_user.meta_id))
        elsif current_user.docente?
            edit_docente_path(Docente.find(current_user.meta_id))
        elsif current_user.representante_externo?
            edit_representante_externo_path(RepresentanteExterno.find(current_user.meta_id))
        else
            edit_admin_path(Admin.find(current_user.meta_id))
        end    
    end
  end
end

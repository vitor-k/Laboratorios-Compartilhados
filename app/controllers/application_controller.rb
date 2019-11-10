class ApplicationController < ActionController::Base
  protected
  before_action :configure_permitted_parameters, if: :devise_controller?


  def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_in) do |user_params|
          user_params.permit(:username, :nusp, :email)
      end
      devise_parameter_sanitizer.permit(:sign_up) do |user_params|
          user_params.permit(:username, :nome, :nusp, :departamento, :RG, :UF, :email, :password, :password_confirmation)
      end
      devise_parameter_sanitizer.permit(:account_update) do |user_params|
          user_params.permit(:username, :nome, :nusp, :departamento, :RG, :UF, :email, :password, :password_confirmation, :current_password)
      end
  end

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
end

# frozen_string_literal: true

class Alunos::RegistrationsController < Devise::RegistrationsController
  include Accessible
  skip_before_action :check_user, except: [:new, :create]
  # before_action :configure_sign_up_params, only: [:create]
  # before_action :configure_account_update_params, only: [:update]

  # GET /resource/sign_up
  def new
    devise_parameter_sanitizer.permit(:sign_up, keys: [:nusp])
    super
  end

  # POST /resource
  def create
    devise_parameter_sanitizer.permit(:sign_up, keys: [:nusp])
    super
  end

  # GET /resource/edit
  # def edit
  #   super
  # end

  # PUT /resource
  # def update
  #   super
  # end

  # DELETE /resource
  def destroy
    # deleta postagens
    @posts = Postagems.all
    @posts.each do |post|
      if (post.aluno_id != nil)
        if (Alunos.find(post.aluno_id) == current_aluno)
          post.destroy
        end
      end
    end
    # deleta pedidos
    @pedidos = Pedidos.all
    @pedidos.each do |pedido|
      if (pedido.aluno_id != nil)
        if (Pedidos.find(pedido.aluno_id) == current_aluno)
          pedido.destroy
        end
      end
    end
    super
  end

  # GET /resource/cancel
  # Forces the session data which is usually expired after sign
  # in to be expired now. This is useful if the user wants to
  # cancel oauth signing in/up in the middle of the process,
  # removing all OAuth session data.
  # def cancel
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_up_params
  #   devise_parameter_sanitizer.permit(:sign_up, keys: [:attribute])
  # end

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_account_update_params
  #   devise_parameter_sanitizer.permit(:account_update, keys: [:attribute])
  # end

  # The path used after sign up.
  # def after_sign_up_path_for(resource)
  #   super(resource)
  # end

  # The path used after sign up for inactive accounts.
  # def after_inactive_sign_up_path_for(resource)
  #   super(resource)
  # end
end

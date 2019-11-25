class AccountsController < ApplicationController
  before_action :authenticate_user!
  def account
    if (docente_signed_in?)
      @docente = Docente.find(current_user.meta_id)
      @laboratorio_docente = @docente.laboratorios
    end
  end

  def edit_password
    if (!user_signed_in?)
        redirect_back(fallback_location: root_path)
    end
    @user = current_user
  end

  def update_password
    @user = current_user
    if @user.update(user_params)
      # Sign in the user by passing validation in case their password changed
      bypass_sign_in(@user)
      redirect_to root_path
    else
      render "edit_password"
    end
  end

  def account_postagens
    if (!user_signed_in?)
      redirect_back(fallback_location: root_path)
    end
  end

  def account_recursos_solicitados
    if (!user_signed_in?)
      redirect_back(fallback_location: root_path)
    end
  end
  
  private

  def user_params
    # NOTE: Using `strong_parameters` gem
    params.require(:user).permit(:password, :password_confirmation)
  end
end
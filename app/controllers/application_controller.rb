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
end

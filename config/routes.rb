Rails.application.routes.draw do
  devise_for :representante_externos
  devise_for :admins
  devise_for :docentes
  devise_for :alunos
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'pages#home'
end

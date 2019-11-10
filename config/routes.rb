Rails.application.routes.draw do
  devise_for :users, skip: [:registrations]
  resources :representante_externos
  resources :admins
  resources :docentes
  resources :alunos

  resources :pedidos
  resources :postagems

  resources :laboratorios do
    resources :servicos
    resources :equipamentos
  end
  # devise_scope :aluno do
  #   authenticated_aluno_root_path to: "pages#home"
  # end

  get 'about_us', to: 'pages#about_us'
  get 'account', to: 'pages#account'

  root 'pages#home'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  # root to: 'pages#home'
end

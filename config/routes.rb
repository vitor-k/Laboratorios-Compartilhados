Rails.application.routes.draw do
  devise_for :users
  resources :representante_externos
  resources :admins
  resources :docentes
  resources :alunos
  resources :pedidos
  resources :postagems
  resources :laboratorios
  resources :servicos
  resources :equipamentos

  # devise_scope :aluno do
  #   authenticated_aluno_root_path to: "pages#home"
  # end

  get 'about_us', to: 'pages#about_us'
  get 'account', to: 'pages#account'

  authenticated :aluno do
    root 'pages#home', as: :authenticated_aluno_root
  end

  authenticated :docente do
    root 'pages#home', as: :authenticated_docente_root
  end

  authenticated :representante_externo do
    root 'pages#home', as: :authenticated_representante_externo_root
  end

  authenticated :admin do
    root 'pages#home', as: :authenticated_admin_root
  end
  
  unauthenticated do
    root 'pages#home', as: :unauthenticated_root
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  # root to: 'pages#home'
end

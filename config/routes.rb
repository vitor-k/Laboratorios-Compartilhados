Rails.application.routes.draw do
  resources :pedidos

  resources :postagems

  resources :laboratorios do
    resources :servicos
    resources :equipamentos
  end

  get '/laboratorios/:id/vinculos', to: 'laboratorios#index_vinculos', as: 'index_vinculos'
  get '/laboratorios/:id/vinculos/vinculo', to: 'laboratorios#vinculo', as: 'new_vinculo'
  post '/laboratorios/:id/vinculos/vinculo', to: 'laboratorios#create_vinculo', as: 'create_vinculo'
  put '/laboratorios/:id/vinculos/vinculo/(:nomeCompleto)/(:nUSP)', to: 'laboratorios#remove_vinculo', as: 'remove_vinculo'
  
  devise_for :representante_externos, path: 'representante_externos', controllers: { 
    sessions: "representante_externos/sessions"
  }
  devise_for :admins, path: 'admins', controllers: {
    sessions: "admins/sessions"
  }
  devise_for :docentes, path: 'docentes', controllers: {
    sessions: "docentes/sessions"
  }
  devise_for :alunos, path: 'alunos', controllers: { 
    sessions: "alunos/sessions"
  }

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

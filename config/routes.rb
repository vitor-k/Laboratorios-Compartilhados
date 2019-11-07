Rails.application.routes.draw do
  resources :pedidos
  resources :postagems
  resources :laboratorios
  resources :servicos
  resources :equipamentos
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

  authenticated :aluno do
    root 'pages#home', as: :authenticated_aluno_root
  end

  authenticated :docente do
    root 'pages#home', as: :authenticated_docente_root
  end

  authenticated :representante_externo do
    root 'pages#home', as: :authenticated_representante_externo_root
  end
  
  unauthenticated do
    root 'pages#home', as: :unauthenticated_root
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  # root to: 'pages#home'
end

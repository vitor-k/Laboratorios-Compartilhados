Rails.application.routes.draw do
  get 'pesquisa', to: 'pesquisa_globals#index', as: 'pesquisa_global'
  devise_for :users, skip: [:registrations]
  resources :representante_externos
  resources :admins
  resources :docentes
  resources :alunos

  resources :pedido_responsabilidades
  get '/account/:id/pedido_responsabilidade', to: 'pedido_responsabilidades#index_docente', as: 'index_docente'
  put '/pedido_responsabilidades/aceitar/(:id)', to: 'pedido_responsabilidades#aceitar', as: 'aceitar'

  
  resources :pedidos
  get '/account/:id/pedidos', to: "pedidos#index_user", as: "index_user"
  get '/laboratorios/:idLab/pedidos', to: "pedidos#show_lab", as: 'show_laboratorio_pedidos'
  put '/laboratorios/:idLab/pedidos/aceitar/(:idPedido)', to: "pedidos#aceitar_pedido", as: 'aceitar_pedido'

  resources :postagems
  resources :postagems, :path => :postagens, as: :postagens

  resources :laboratorios do
    member do
      get :busca
    end
    resources :vinculo, only: [:index, :new, :create, :update]
    resources :servicos
    resources :equipamentos
  end
  
  get 'about_us', to: 'pages#about_us'
  get 'indicador_global', to: 'pages#indicador_global'
  get 'account', to: 'pages#account'
  get 'account/postagens', to: 'pages#account_postagens'
  get 'account/recursos_solicitados', to: 'pages#account_recursos_solicitados'

  root 'pages#home'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  # root to: 'pages#home'
end

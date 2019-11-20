Rails.application.routes.draw do
  devise_for :users, skip: [:registrations]
  resources :representante_externos
  resources :admins
  resources :docentes
  resources :alunos
  resources :pedido_responsabilidades
  get '/account/:id/pedido_responsabilidade', to: 'pedido_responsabilidades#index_docente', as: 'index_docente'
  put '/pedido_responsabilidades/aceitar/(:id)', to: 'pedido_responsabilidades#aceitar', as: 'aceitar'
  resources :pedidos
  get '/pedido/:tipo/:id/:idEquipamento', to: "pedidos#new", as: 'new_pedido_alternativo'
  post '/pedido/:tipo/:id/:idEquipamento', to: "pedidos#blabla", as: 'create_pedido_alternativo'
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


  # get '/laboratorios/:id/vinculos', to: 'laboratorios#index_vinculos', as: 'index_vinculos'
  # get '/laboratorios/:id/vinculos/vinculo', to: 'laboratorios#vinculo', as: 'new_vinculo'
  # post '/laboratorios/:id/vinculos/vinculo', to: 'laboratorios#create_vinculo', as: 'create_vinculo'
  # put '/laboratorios/:id/vinculos/vinculo/(:nomeCompleto)/(:nUSP)', to: 'laboratorios#remove_vinculo', as: 'remove_vinculo'
  
  get 'about_us', to: 'pages#about_us'
  get 'account', to: 'pages#account'
  get 'account/postagens', to: 'pages#account_postagens'

  root 'pages#home'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  # root to: 'pages#home'
end

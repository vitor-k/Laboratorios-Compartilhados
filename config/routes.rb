Rails.application.routes.draw do
  resources :pedidos
  resources :servicos
  resources :equipamentos
  resources :postagems
  resources :laboratorios
  devise_for :usuarios
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end

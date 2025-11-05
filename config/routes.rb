# config/routes.rb

Rails.application.routes.draw do
  # Rotas padrão do Devise para autenticação de usuários
  devise_for :users

  # Cria todas as 7 rotas CRUD RESTful: index, show, new, create, edit, update, destroy
  resources :tasks

  # Gerenciamento de usuários(apenas admin)
  resources :users, only: [ :index, :edit, :update, :destroy ]

  # Define a página inicial para listar todas as tarefas
  root "tasks#index"
end

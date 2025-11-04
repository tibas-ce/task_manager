# config/routes.rb

Rails.application.routes.draw do
  # Cria todas as 7 rotas CRUD RESTful: index, show, new, create, edit, update, destroy
  resources :tasks

  # Define a página inicial para listar todas as tarefas
  root "tasks#index"
end

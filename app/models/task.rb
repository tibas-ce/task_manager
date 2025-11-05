class Task < ApplicationRecord
  # Associação: cada tarefa pertence a um usuário, garantindo que toda tarefa esteja vinculada a alguém autenticado no sistema.
  belongs_to :user

  # Validação para garantir que o título da tarefa não seja deixado em branco
  validates :title, presence: true

  # Validação para assegurar que a descrição tenha um conteúdo mínimo significativo
  validates :description, length: { minimum: 10 }
end

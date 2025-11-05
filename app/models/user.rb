class User < ApplicationRecord
  # Módulos do Devise responsáveis por autenticação, cadastro, recuperação de senha, sessão lembrada e validações automáticas
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # Associação: um usuário pode possuir várias tarefas.
  # Se o usuário for removido, todas as suas tarefas são removidas automaticamente.
  has_many :tasks, dependent: :destroy
end

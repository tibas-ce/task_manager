class AddAdminToUsers < ActiveRecord::Migration[8.0]
  def change
    # Adiciona o campo booleano 'admin' para controlar privilégios de usuário no sistema.
    # O valor padrão 'false' garante que apenas usuários explicitamente promovidos sejam administradores.
    add_column :users, :admin, :boolean, default: false
  end
end

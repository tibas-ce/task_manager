# find_or_initialize_by evita duplicar registros e permite atualizar dados.
# save! garante que, se houver erro, você descobre na hora.

# Cria ou encontra o usuário e atualiza atributos caso já exista
admin = User.find_or_initialize_by(email: "admin@exemplo.com")
admin.name = "Administrador geral"
admin.password = "password123"
admin.password_confirmation = "password123"
admin.admin = true
admin.save!

# Cria ou encontra o usuário comum
user = User.find_or_initialize_by(email: "user@exemplo.com")
user.name = "Usuário comum"
user.password = "password123"
user.password_confirmation = "password123"
user.admin = false
user.save!

puts "Usuários criados/atualizados:"
puts "- Admin: #{admin.email} (#{admin.name})"
puts "- Usuário: #{user.email} (#{user.name})"
puts "Senha padrão: password123"

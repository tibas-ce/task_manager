FactoryBot.define do
  # Factory padrão para um usuário comum
  factory :user do
    name { "Teste User" }
    # Garante e-mails únicos
    sequence(:email) { |n| "user#{n}@teste.com" }
    password { "password123" }
    password_confirmation { "password123" }
    # Padrão: usuário comum
    admin { false }
  end

  # Factory para um usuário administrador (herda tudo do :user, mas altera o 'admin')
  factory :admin_user, parent: :user do
    name { "Admin User" }
    admin { true }
  end
end

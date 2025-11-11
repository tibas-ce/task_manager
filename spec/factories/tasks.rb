FactoryBot.define do
  factory :task do
    # Define títulos únicos para cada instância criada pela factory
    sequence(:title) { |n| "Tarefa de teste#{n}" }
    description { "Descrição longa da tarefa de teste com mais de 10 caracteres." }
    completed { false }

    # Associação: Garante que cada tarefa criada pertence a um usuário
    association :user
  end
end

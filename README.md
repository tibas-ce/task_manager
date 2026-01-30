> ⚠️ **Projeto de Estudos**  
> Este projeto tem foco educacional e de portfólio, priorizando clareza de regras de negócio, organização de código e boas práticas de teste.


# Task Manager

![Tests](https://img.shields.io/badge/tests-18%20passing-brightgreen)
![Rails](https://img.shields.io/badge/rails-8.0.4-red)
![Ruby](https://img.shields.io/badge/ruby-3.4.5-red)

Aplicação simples em Ruby on Rails para gerenciamento de tarefas (Tasks), com autenticação de usuários e controle de permissões.

O objetivo deste projeto é demonstrar conhecimentos fundamentais em Rails, incluindo:
- autenticação com Devise
- associações entre models
- validações
- autorização baseada em papéis (usuário comum e administrador)
- testes automatizados focados em regras de negócio

---

## 🚀 Funcionalidades

- Usuários comuns podem:
  - criar tarefas
  - editar apenas suas próprias tarefas
  - visualizar apenas suas próprias tarefas
- Administradores podem:
  - criar tarefas
  - editar tarefas de qualquer usuário
  - visualizar todas as tarefas
  - excluir tarefas
- Usuários não autenticados:
  - não podem criar, editar ou excluir tarefas
  - são redirecionados para a página de login

---

## 🧱 Modelos

### User
- Autenticação com Devise
- Associa-se a várias tarefas (`has_many :tasks`)
- Campo `admin` (boolean) para identificar administradores

### Task
- Pertence a um usuário (`belongs_to :user`)
- Valida presença de título e usuário
- Armazena título e descrição

---

## 🔐 Regras de Autorização

- Apenas usuários autenticados podem criar e editar tarefas
- Usuários comuns só podem editar tarefas próprias
- Apenas administradores podem excluir tarefas
- Usuários veem apenas suas próprias tarefas; apenas administradores veem todas

---

## 📋 Pré-requisitos

- Ruby 3.4.5
- Rails 8.0.4
- SQLite3

---

## ▶️ Como rodar o projeto

#### Clone o repositório

```bash
git clone https://github.com/tibas-ce/task_manager.git
cd task_manager
```

#### Instale as dependências

```bash
bundle install
```

#### Configure o banco de dados

```bash
rails db:create db:migrate
```

#### (Opcional) Popule o banco com dados de exemplo

```bash
rails db:seed
```

#### Inicie o servidor

```bash
rails server
```

Acesse http://localhost:3000

---

## 🎭 Credenciais
Após rodar `rails db:seed`, você pode logar com:

#### Administrador:

Email: admin@exemplo.com

Senha: password123

#### Usuário comum:

Email: user@exemplo.com

Senha: password123

---

## ▶️ Como rodar os testes

```bash
bundle exec rspec
```

---

## 🧪 Testes

Este projeto utiliza **RSpec** para testes automatizados.

### Model Specs
Foram utilizados para garantir:
- validações essenciais dos modelos
- associações entre `User` e `Task`

### Request Specs (por que foram usados)

As regras de autorização e autenticação da aplicação foram testadas utilizando **request specs**, em vez de controller specs.

Isso foi feito porque:
- controller specs são considerados obsoletos nas versões modernas do Rails
- request specs testam o comportamento real da aplicação, passando pelo stack completo (rotas, autenticação, controller e resposta)
- esse tipo de teste se aproxima mais da experiência real do usuário e garante maior confiabilidade das regras de negócio

Os request specs cobrem cenários como:
- usuário autenticado vs não autenticado
- usuário dono da tarefa
- usuário administrador
- usuário comum tentando acessar recursos sem permissão

---

## 📚 O que aprendi neste projeto

- Autenticação: Implementação do Devise e personalização de views
- Autorização: Lógica de permissões baseada em papéis (roles)
- Testes: Diferença entre controller specs (obsoletos) e request specs (modernos)
- Active Record: Associações has_many e belongs_to com dependent destroy
- Validações: Garantir integridade de dados no model layer
- RSpec: Organização de testes em contexts e describes

---

## 🛠️ Stack

- Ruby on Rails 8.0.4
- Ruby 3.4.5
- Devise - Autenticação
- RSpec - Framework de testes
- SQLite - Banco de dados (desenvolvimento)

---

## 👨‍💻 Autor

Tibério dos Santos Ferreira  
GitHub: https://github.com/tibas-ce

---

## 📄 Licença

Este projeto está sob a licença MIT. Veja o arquivo LICENSE para mais detalhes.
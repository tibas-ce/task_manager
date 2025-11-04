class TasksController < ApplicationController
  # O método set_task será executado antes das ações 'show', 'edit', 'update' e 'destroy'
  before_action :set_task, only: [ :show, :edit, :update, :destroy ]

  # --- Ações de LEITURA (Read) ---

  # 1. INDEX (Listar todos)
  def index
    # Active Record: Recupera todas as tarefas do banco de dados
    @tasks = Task.all.order(created_at: :desc)
  end

  # 2. SHOW (Mostrar detalhes de uma)
  def show
    # @task já está definido pelo "set_task"
  end

  # --- Ações de CRIAÇÃO (Create) ---

  # 3. NEW (Prepara um novo objeto)
  def new
    # Prepara um objeto Task vazio para o formulário
    @task = Task.new
  end

  # 4. CREATE (Salva no banco)
  def create
    # 1. Cria um novo objeto com os parâmetros permitidos (task_params)
    @task = Task.new(task_params)

    # 2. Tenta salvar no banco e redireciona ou renderiza o formulário novamente
    if @task.save
      # Redireciona para a página de detalhes da nova task
      redirect_to @task, notice: "Tarefa criada com sucesso!"
    else
      # Se houver erro de validação, renderiza a view 'new' (com os erros)
      render :new, status: :unprocessable_entity
    end
  end

  # --- Ações de ATUALIZAÇÃO (Update) ---

  # 5. EDIT (Busca e prepara para edição)
  def edit
    # @task já está definido pelo "set_task"
  end

  # 6. UPDATE (Aplica as mudanças no banco)
  def update
    # 1. Tenta atualizar o objeto com os parâmetros permitidos
    if @task.update(task_params)
      # Redireciona para a página de detalhes da task atualizada
      redirect_to @task, notice: "Tarefa atualizada com sucesso!"
    else
      # Se houver erro de validação, renderiza a view 'edit' (com os erros)
      render :edit, status: :unprocessable_entity
    end
  end

  # --- Ação de DELETAR (Delete) ---

  # 7. DESTROY (Remove do banco)
  def destroy
    # Remove o objeto do banco de dados
    @task.destroy
    # Redireciona para a lista de tarefas
    redirect_to tasks_url, notice: "Tarefa excluída com sucesso!"
  end

  # --- Métodos Privados (Auxiliares) ---

  private

  # Método para buscar uma tarefa pelo ID antes das ações que precisam dela.
  def set_task
    @task = Task.find(params[:id])
  end

  # STRONG PARAMS: Define quais parâmetros são permitidos. ESSENCIAL para segurança.
  def task_params
    params.require(:task).permit(:title, :description, :completed)
  end
end

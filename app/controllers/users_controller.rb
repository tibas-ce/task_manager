class UsersController < ApplicationController
  # Exige que o usuário esteja autenticado para acessar qualquer ação
  before_action :authenticate_user!

  # Garante que apenas administradores tenham acesso às ações deste controller
  before_action :require_admin

  # Localiza o usuário antes das ações de edição, atualização e exclusão
  before_action :set_user, only: [ :edit, :update, :destroy ]

  # --- Ações de LEITURA (Read) ---

  # LISTAGEM de usuários (somente admins podem ver)
  def index
    # Ordena os usuários por email (ordem alfabética)
    @users = User.all.order(email: :asc)
  end

  # --- Ações de ATUALIZAÇÃO (Update) ---

  # FORMULÁRIO de edição
  def edit
    # @user já foi carregado pelo before_action :set_user
  end

  # ATUALIZA os dados do usuário
  def update
    if @user.update(user_params)
      redirect_to users_path, notice: "Usuário #{@user.email} atualizado com sucesso."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # --- Ação de DELETAR (Delete) ---

  # EXCLUI um usuário
  def destroy
    @user.destroy
    redirect_to users_path, notice: "Usuário #{@user.email} excluído com sucesso."
  end

  # --- Métodos Privados (Auxiliares) ---

  private

  # Busca o usuário e impede que um admin edite suas próprias permissões aqui
  def set_user
    if params[:id].to_i == current_user.id
      redirect_to users_path, alert: "Você não pode editar suas próprias permissões de Admin por aqui." and return
    end
    @user = User.find(params[:id])
  end

  # Strong Params — define quais atributos podem ser alterados
  def user_params
    params.require(:user).permit(:admin)
  end

  # Bloqueia acesso caso o usuário não seja admin
  def require_admin
    unless current_user.admin?
      redirect_to root_path, alert: "Acesso negado. Somente administradores podem gerenciar usuários"
    end
  end
end

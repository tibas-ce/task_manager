require 'rails_helper'

RSpec.describe TasksController, type: :controller do
  # Define os usuários e tarefas que serão usados em vários testes
  let(:owner) { create(:user) }
  let(:other_user) { create(:user) }
  let(:admin) { create(:admin_user) }
  let!(:task) { create(:task, user: owner) } # Task pertence ao :owner

  # Helper para simular login com Devise
  def sign_in_as(user)
    sign_in user
  end

  # TESTES DE CRIAÇÃO (NEW/CREATE)

  describe 'POST #create' do
    context 'Como usuário comum (dono da tarefa)' do
      before { sign_in_as owner }

      it 'cria uma nova Task' do
        expect {
          post :create, params: { task: attributes_for(:task) }
        }.to change(Task, :count).by(1)
        # Verifica se o user_id foi atribuído corretamente
        expect(Task.last.user).to eq(owner)
      end
    end

    context 'Como ADMIN' do
      before { sign_in_as admin }

      it 'cria uma nova Task' do
        expect {
          post :create, params: { task: attributes_for(:task) }
        }.to change(Task, :count).by(1)
        # Verifica se o user_id foi atribuído corretamente ao ADMIN
        expect(Task.last.user).to eq(admin)
      end
    end
  end

  # TESTES DE EDIÇÃO/UPDATE

  describe 'PATCH #update' do
    let(:new_title) { "Título Atualizado" }

    context 'Usuário Comum que é DONO da Task' do
      before { sign_in_as owner }

      it 'atualiza a Task com sucesso' do
        patch :update, params: { id: task.id, task: { title: new_title } }
        task.reload
        expect(task.title).to eq(new_title)
        expect(response).to redirect_to(task)
      end
    end

    context 'Usuário Comum que NÃO é Dono da Task' do
      before { sign_in_as other_user }

      it 'NÃO atualiza a Task e redireciona com alerta' do
        patch :update, params: { id: task.id, task: { title: new_title } }
        task.reload
        expect(task.title).not_to eq(new_title) # Garante que não mudou
        expect(response).to redirect_to(tasks_path)
        expect(flash[:alert]).to include("Acesso negado. Você só pode editar tarefas próprias.")
      end
    end

    context 'Usuário ADMIN' do
      before { sign_in_as admin }

      it 'atualiza a Task de qualquer usuário com sucesso' do
        patch :update, params: { id: task.id, task: { title: new_title } }
        task.reload
        expect(task.title).to eq(new_title) # Garante que o Admin pode editar
        expect(response).to redirect_to(task)
      end
    end
  end

  # TESTES DE EXCLUSÃO (DESTROY)

  describe 'DELETE #destroy' do
    context 'Usuário Comum (Dono ou Não-Dono)' do
      before { sign_in_as owner } # Testa o dono, mas o resultado é o mesmo para não-dono

      it 'NÃO exclui a Task e redireciona com alerta' do
        expect {
          delete :destroy, params: { id: task.id }
        }.not_to change(Task, :count) # Garante que o contador de Tasks não muda
        expect(response).to redirect_to(tasks_path)
        expect(flash[:alert]).to include("Acesso negado. Somente administradores podem excluir tarefas.")
      end
    end

    context 'Usuário ADMIN' do
      before { sign_in_as admin }

      it 'exclui a Task com sucesso' do
        expect {
          delete :destroy, params: { id: task.id }
        }.to change(Task, :count).by(-1) # Garante que o contador diminui em 1
        expect(response).to redirect_to(tasks_url)
      end
    end
  end
end

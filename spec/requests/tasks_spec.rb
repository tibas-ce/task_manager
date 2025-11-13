# spec/requests/tasks_spec.rb
require 'rails_helper'

RSpec.describe "Tasks", type: :request do
  # Cria usuários e tarefa base para os testes
  let(:owner) { create(:user) }
  let(:admin) { create(:admin_user) }
  let!(:task) { create(:task, user: owner) }
  let(:other_user) { create(:user) }

  # TESTES DE CRIAÇÃO (POST /tasks)

  describe "POST /tasks" do
    let(:valid_attributes) { attributes_for(:task) }

    context "Como usuário comum (dono da tarefa)" do
      before { login_as owner, scope: :user }

      it "cria uma nova Task e associa ao usuário logado" do
        expect do
          post tasks_url, params: { task: valid_attributes }
        end.to change(Task, :count).by(1)

        expect(Task.last.user_id).to eq(owner.id)
        expect(response).to have_http_status(:redirect)
      end
    end

    context "Como ADMIN" do
      before { login_as admin, scope: :user }

      it "cria uma nova Task e atribui ao ADMIN" do
        expect do
          post tasks_url, params: { task: valid_attributes }
        end.to change(Task, :count).by(1)

        expect(Task.last.user_id).to eq(admin.id)
        expect(response).to have_http_status(:redirect)
      end
    end

    context "Sem usuário logado" do
      it "não cria a Task e redireciona para login" do
        expect do
          post tasks_url, params: { task: valid_attributes }
        end.to change(Task, :count).by(0)

        expect(response).to redirect_to(new_user_session_url)
      end
    end
  end

  # TESTES DE EDIÇÃO/ATUALIZAÇÃO (PATCH /tasks)

  describe "PATCH /tasks/:id" do
    let(:new_title) { "Título Atualizado com Sucesso" }
    let(:invalid_attributes) { { title: "" } }

    context "Como usuário DONO da Tarefa" do
      before { login_as owner, scope: :user }

      it "atualiza com sucesso" do
        patch task_url(task), params: { task: { title: new_title } }
        task.reload

        expect(task.title).to eq(new_title)
        expect(response).to redirect_to(task_url(task))
      end

      it "não atualiza com atributos inválidos" do
        patch task_url(task), params: { task: invalid_attributes }
        task.reload

        expect(task.title).not_to eq("")
        expect(response).to have_http_status(:unprocessable_content)
      end
    end

    context "Como usuário ADMIN" do
      before { login_as admin, scope: :user }

      it "atualiza tarefas de outros usuários" do
        patch task_url(task), params: { task: { title: new_title } }
        task.reload

        expect(task.title).to eq(new_title)
        expect(response).to have_http_status(:redirect)
      end
    end

    context "Como outro usuário comum (não dono)" do
      before { login_as other_user, scope: :user }

      it "NÃO atualiza e redireciona com alerta (Acesso Negado)" do
        patch task_url(task), params: { task: { title: new_title } }
        task.reload

        expect(task.title).not_to eq(new_title)
        expect(response).to redirect_to(tasks_url)
        expect(flash[:alert]).to include("Acesso negado. Você só pode editar tarefas próprias.")
      end
    end
  end

  # TESTES DE EXCLUSÃO (DELETE /tasks)

  describe "DELETE /tasks/:id" do
    context "Como usuário ADMIN" do
      before { login_as admin, scope: :user }

      it "exclui a Tarefa e redireciona com sucesso" do
        expect {
          delete task_url(task)
        }.to change(Task, :count).by(-1)

        expect(response).to redirect_to(tasks_url)
        expect(flash[:notice]).to include("Tarefa excluída com sucesso!")
      end
    end

    context "Como usuário DONO da Task" do
      before { login_as owner, scope: :user }

      it "não exclui a Tarefa e redireciona com alerta" do
        expect {
          delete task_url(task)
        }.not_to change(Task, :count)

        expect(response).to redirect_to(tasks_url)
        expect(flash[:alert]).to include("Acesso negado. Somente administradores podem excluir tarefas.")
      end
    end

    context "Sem usuário logado" do
      it "não exclui a Task e redireciona para login" do
        expect {
          delete task_url(task)
        }.not_to change(Task, :count)

        expect(response).to redirect_to(new_user_session_url)
      end
    end
  end
end

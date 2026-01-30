# spec/models/task_spec.rb
require 'rails_helper'

RSpec.describe Task, type: :model do
  describe "Validações" do
    it "é válida com título e usuário" do
      task = build(:task)
      expect(task).to be_valid
    end

    it "é inválida sem título" do
      task = build(:task, title: nil)
      expect(task).not_to be_valid
    end

    it "é inválida sem usuário" do
      task = build(:task, user: nil)
      expect(task).not_to be_valid
    end
  end

  describe "Associações" do
    it "pertence a um usuário" do
      user = create(:user)
      task = create(:task, user: user)

      expect(task.user).to eq(user)
    end
  end
end

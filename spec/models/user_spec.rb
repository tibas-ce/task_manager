# spec/models/user_spec.rb
require 'rails_helper'

RSpec.describe User, type: :model do
  describe "Validações" do
    it "é válido com email e senha" do
      user = build(:user)
      expect(user).to be_valid
    end

    it "é inválido sem email" do
      user = build(:user, email: nil)
      expect(user).not_to be_valid
    end

    it "é inválido sem senha" do
      user = build(:user, password: nil)
      expect(user).not_to be_valid
    end
  end

  describe "Associações" do
    it "tem muitas tarefas" do
      user = create(:user)
      create(:task, user: user)
      create(:task, user: user)

      expect(user.tasks.count).to eq(2)
    end
  end
end

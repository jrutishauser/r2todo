require 'rails_helper'

RSpec.describe TodosController, type: :controller do

  describe "POST #CREATE" do
    it "Should create a todo item" do
      expect {
        post :create, todo: { task: 'my task' }
      }.to change {Todo.count}.by(1)
    end
  end
  describe "DELETE #destroy" do
    it "should delete a record" do
      todo = create(:todo)
      expect {
        delete :destroy, id: todo.id
      }.to change{Todo.count}.by(-1)
    end

    it "should return 200" do
      todo = create(:todo)
        delete :destroy, id: todo.id
        expect(response.status).to eq(204)
    end

    describe "with invalid id" do
      it "should return 200" do
        delete :destroy, id: 93121
        expect(response.status).to eq(404)
      end
    end
  end

end

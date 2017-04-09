require 'rails_helper'

RSpec.describe Todo, type: :model do

  describe "with new todo" do
    it "should not be valid without a task" do
      todo = build(:todo)
      todo.task = nil
      expect(todo.valid?).to be(false)
    end
  end

  describe "with todo" do
    describe "#can_delete?" do
      it "should return false if the todo is complete" do
        todo = build(:todo)
        todo.is_completed = true
        expect(todo.can_delete?).to be(false)
      end
    end
  end
end

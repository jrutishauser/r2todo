class TodosController < ApplicationController

  before_action :set_todo, only: [:show, :update, :destroy]

  def index
    @todos = Todo.all

    render json: @todos
  end
  def create
    @todo = Todo.new(todo_params)
      if @todo.save
        render json: @todo
      else
        render json: @todo.errors
      end
  end
  def update
    if @todo.update(todo_params)
      render json: @todo
    else
      render json: @todo.errors, status: :unprocessable_entity
    end
  end
  def destroy
    @todo.destroy
  end
  private
    def todo_params
      params.require(:todo).permit(:task, :is_completed)
    end

    def set_todo
      @todo = Todo.find_by_id(params[:id])
      unless @todo
        render status: 404, text: ''
        return false
      end
    end
end

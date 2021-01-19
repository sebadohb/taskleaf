class TasksController < ApplicationController
  before_action :set_params, only: [:show, :edit, :update, :destroy ]
  def index
    @tasks = Task.all
  end

  def new
    @task = Task.new
  end
  def create
    task = Task.new(task_params)
    task.save!
    redirect_to root_path, notice: "タスク「#{@task.name}」を登録しました。"
  end

  def show
  end

  def edit
    
  end
  def update
    @task.update!(task_params)
    redirect_to root_path, notice: "タスク「#{@task.name}」を更新しました。"
  end
  def destroy
    @task.destroy
    redirect_to root_path, notice: "タスク「#{@task.name}」を削除しました。"
  end


  private
  def task_params
    params.require(:task).permit(:name, :description)
  end
  def set_params
    @task = Task.find(params[:id])
  end
end

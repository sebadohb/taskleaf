class TasksController < ApplicationController
  before_action :baria_user, only: [:show, :edit, :update, :destroy ]
  before_action :set_params, only: [:show, :edit, :update, :destroy ]
  
  
  def index
    @tasks = current_user.tasks.recent
  end

  def new
    @task = Task.new
  end
  def create
    @task = current_user.tasks.new(task_params)
    
    if @task.save
      redirect_to @task, notice: "タスク「#{@task.name}」を登録しました。"
    else
      render :new
    end

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
    @task = current_user.tasks.find(params[:id])
  end
  def baria_user
    unless Task.find(params[:id]).user_id == current_user.id
        redirect_to tasks_url
    end
  end
end

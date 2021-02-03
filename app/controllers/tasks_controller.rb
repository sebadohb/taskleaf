class TasksController < ApplicationController
  before_action :baria_user, only: [:show, :edit, :update, :destroy ]
  before_action :set_params, only: [:show, :edit, :update, :destroy ]
  
  
  def index
    @q = current_user.tasks.ransack(params[:q])
    @tasks = @q.result(distinct: true).page(params[:page]).per(50)
    respond_to do |format|
      format.html
      format.csv { send_data @tasks.generate_csv, filename: "tasks-#{Time.zone.now.strftime('%Y%m%d%S')}.csv"}
    end
  end

  def new
    @task = Task.new
  end
  def create
    @task = current_user.tasks.new(task_params)
    if params[:back].present?
      render :new
      return
    end
    
    if @task.save
      TaskMailer.creation_email(@task).deliver_now
      SampleJob.perform_later
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
  end

  def confirm_new
    @task = current_user.tasks.new(task_params)
    render :new unless @task.valid?
  end
  def import 
    current_user.tasks.import(params[:file])  #現在のuserのtaskにimportを発動させる
    redirect_to tasks_url, notice: "タスクを追加しました"
  end


  private
  def task_params
    params.require(:task).permit(:name, :description, :image)
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

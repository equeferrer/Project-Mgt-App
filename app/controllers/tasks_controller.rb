class TasksController < ApplicationController
  before_action :authenticate_user!
  before_action :get_category, only: [:index, :new, :create]
  before_action :set_task_user, only: [:edit, :update, :destroy]
  before_action :owns_task?, only: [:edit, :update, :destroy]

  # def index
  #   @tasks = @category.tasks
  # end
  
  def new 
    @task = current_user.tasks.build 
  end

  def create
    @task = current_user.tasks.build(task_params)
    @task.user_id = current_user.id
    @task.category_id = @category.id
    @task.project_id = @category.project_id
    if @task.save 
	    redirect_to project_path(@task.project_id)
    else 
      render :new
    end
  end

  def edit
    @task = current_user.tasks.find(set_project)
  end

  def update
    @task = current_user.tasks.find(set_project)
    if @task.update(task_params)
      redirect_to project_path(@task.project_id)
    else 
      render :edit
    end
  end

  def destroy
    @task = current_user.tasks.find(set_project)
    @task.destroy
    redirect_to project_path(@task.project_id)
  end

  private
  def set_project
    params[:id]
  end

  def get_category
    @category = Category.find(params[:category_id])
  end

  def task_params
    params.require(:task).permit(:name, :category_id, :description, :priority_level, :due_date, :user_id, :project_id)
  end

  def set_task_user
    @task = Task.find(params[:id])
  end
  
  def owns_task?
    redirect_to projects_path unless current_user.id == @task.user_id 
  end
end

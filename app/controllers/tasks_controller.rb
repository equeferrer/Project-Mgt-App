class TasksController < ApplicationController
  before_action :get_category, only: [:index, :new, :create]

  def index
    @tasks = @category.tasks
  end
  
  def new 
    @task = @category.tasks.build 
  end

  def create
    @task = @category.tasks.build(task_params)
    if @task.save
	    redirect_to category_tasks_path
    else 
      render :new
    end
  end

  def edit
    @task = Task.find(params[:id])
  end

  def update
    @task = Task.find(params[:id])
    if @task.update(task_params)
      redirect_to task_path
    else 
      render :edit
    end
  end

  def destroy
    @task = Task.find(params[:id])
    @task.destroy
      # redirect_to category_tasks_path @category
    # else
    #   render :edit
    # end
  end

  private
  def get_category
    # @project = Project.find(params[:project_id])
    @category = Category.find(params[:category_id])
  end

  def task_params
    params.require(:task).permit(:name, :category_id, :description, :priority_level, :due_date)
  end
end

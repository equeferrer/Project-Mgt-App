class TasksController < ApplicationController
  before_action :get_category 

  def index
    @tasks = @category.tasks
  end
  
  def new 
    @task = @category.tasks.build 
	  #built-in way to instantiate 
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
  end

  def update
    @task = @category.tasks.find(params[:id])
    if @task.update(task_params)
      redirect_to category_tasks_path
    else 
      render :edit
    end
  end

  def destroy
    @task = @category.tasks.find(params[:id])
    if @task.destroy
      redirect_to category_tasks_path
    else
      render :edit
    end
  end

  private
  def get_category
    @category = Category.find(params[:category_id])
  end

  def task_params
    params.require(:task).permit(:name, :category_id, :description, :priority_level, :due_date)
  end
end

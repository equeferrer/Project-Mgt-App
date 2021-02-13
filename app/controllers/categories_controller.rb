class CategoriesController < ApplicationController
  before_action :get_project, only: [:index, :new, :create]

  def index
    @category = @project.categories
  end

  def new
    @category = @project.categories.build
  end

  def create
    @category = @project.categories.build(category_params)
    if @category.save
      redirect_to project_categories_path
    else
      render :new
    end
  end

  def edit
    @category = Category.find(set_category)
  end

  def update
    @category = Category.find(set_category)
    if @category.update(category_params)
      redirect_to category_path
    else 
      render :edit
    end
  end

  def destroy
    @category = Category.find(set_category)
    @category.destroy
    # @project = Project.find(params[:project_id])
    # redirect_to project_categories_path @project
    # if else render?
  end

  private
  def get_project
    # @project = Project.new
    @project = Project.find(params[:project_id])
  end
  
  def set_category
    params[:id]
  end

  def category_params
    params.require(:category).permit(:title, :project_id)
  end
end

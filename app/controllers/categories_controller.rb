class CategoriesController < ApplicationController
  before_action :authenticate_user!
  before_action :get_project, only: [:index, :new, :create]
  before_action :set_category_user, only: [:edit, :update, :destroy]
  before_action :owns_category?, only: [:edit, :update, :destroy]
  # def index
  #   @categories = @project.categories
  # end

  def new
    @category = current_user.categories.build
  end

  def create
    @category = current_user.categories.build(category_params)
    @category.user_id = current_user.id
    @category.project_id = @project.id
    if @category.save
      redirect_to project_path @project
    else
      render :new
    end
  end

  def edit
    @category = current_user.categories.find(set_category)
  end

  def update
    @category = current_user.categories.find(set_category)
    if @category.update(category_params)
      redirect_to project_path(@category.project_id)
    else 
      render :edit
    end
  end

  def destroy
    @category = current_user.categories.find(set_category)
    @category.destroy
    redirect_to project_path(@category.project_id)
  end

  private
  def get_project
    @project = current_user.projects.find(params[:project_id])
  end
  
  def set_category
    params[:id]
  end

  def category_params
    params.require(:category).permit(:title, :project_id, :user_id)
  end

  def set_category_user
    @category = Category.find(params[:id])
  end
  
  def owns_category?
    redirect_to projects_path unless current_user.id == @category.user_id 
  end
end

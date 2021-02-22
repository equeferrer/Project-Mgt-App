class ProjectsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_project_user, only: [:show, :edit, :update, :destroy]
  before_action :user_is_owner?, only: [:show, :edit, :update, :destroy]


  def index
    @projects = current_user.projects
  end

  def new
    @project = current_user.projects.build
    @projects = current_user.projects
  end

  def show
    @project = current_user.projects.find(set_project)
  end

  def create
    @project = current_user.projects.build(project_params)
    @projects = current_user.projects
    # category.title = params[:title]
    
    if @project.save
      redirect_to project_path(@project)
    else
      render :new
    end
  end

  def edit
    @project = current_user.projects.find(set_project)
  end

  def update
    @project = current_user.projects.find(set_project)
    if @project.update(project_params)
      redirect_to project_path(@project)
    else 
      render :edit
    end
  end

  def destroy
    @project = current_user.projects.find(set_project)
    @project.destroy
    redirect_to projects_path
  end

  private

  def set_project
    params[:id]
  end

  def project_params
    params.require(:project).permit(:name, :description)
  end

  def set_project_user
    @project = Project.find(params[:id])
  end
  
  def user_is_owner?
    redirect_to projects_path unless current_user.id == @project.user_id 
  end
end

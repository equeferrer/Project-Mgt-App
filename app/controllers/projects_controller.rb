class ProjectsController < ApplicationController
  
  def index
    @project = Project.new
  end

  def new
    @project = Project.new
  end

  def create
    @project = Project.new(project_params)
    # category.title = params[:title]
    
    if @project.save
      redirect_to projects_path
    else
      render :new
    end
  end

  def edit
    @project = Project.find(set_project)
  end

  def update
    @project = Project.find(set_project)
    if @project.update(project_params)
      redirect_to projects_path
    else 
      render :edit
    end
  end

  def destroy
    @project = Project.find(set_project)
    @project.destroy
    # redirect_to categories_path
  end

  private

  def set_project
    params[:id]
  end

  def project_params
    params.require(:project).permit(:name)
  end
end

class HomeController < ApplicationController
  def index
    if user_signed_in? 
      @projects = current_user.projects
      @tasks = current_user.tasks

      @priority_tasks = Task.priority.where(user_id: current_user.id)
    end
  end
end

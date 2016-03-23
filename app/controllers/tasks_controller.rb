class TasksController < ApplicationController
  def index
  	@users = User.all
  end
end

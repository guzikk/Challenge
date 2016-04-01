class TasksController < ApplicationController
 
 layout 'bootstrap'

 def index
 	@users = User.all
 end

end

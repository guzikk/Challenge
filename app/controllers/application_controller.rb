class ApplicationController < ActionController::Base
  layout 'bootstrap'
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?
 
  def configure_permitted_parameters
 	devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:name, :surname, :credit, :email, :password, :avatar) }
    devise_parameter_sanitizer.for(:account_update) { |u| u.permit(:name, :surname, :credit,  :email, :password, :current_password, :avatar) }
  end
end

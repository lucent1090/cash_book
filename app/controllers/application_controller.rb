class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?

  def after_sign_in_path_for( user )
  	users_path
  end

protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_in) << :name
    devise_parameter_sanitizer.for(:sign_up) << :name
    devise_parameter_sanitizer.for(:account_update) << :name
    devise_parameter_sanitizer.for(:account_update) << :budget_per_day
    devise_parameter_sanitizer.for(:account_update) << :all_groups
  end
end

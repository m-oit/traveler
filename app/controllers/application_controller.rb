class ApplicationController < ActionController::Base
  
  protect_from_forgery

  before_action :authenticate_user!, except: [:top, :about], unless: :admin_controller?
  before_action :configure_permitted_parameters, if: :devise_controller?

  
  def after_sign_in_path_for(resource)
    user_path(resource)
  end

  def after_sign_up_path_for(resource)
    user_path(current_user.id)
  end

  def after_sign_out_path_for(resource)
    top_path
  end

  private
 
  def admin_controller?
    self.class.module_parent_name == 'Admin'
  end

    protected
  
  
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
  end
 end
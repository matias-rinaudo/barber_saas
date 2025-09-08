class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?
  
  protected
  
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :role, :barbershop_id])
    devise_parameter_sanitizer.permit(:account_update, keys: [:name, :role, :barbershop_id])
  end
  
  def after_sign_in_path_for(resource)
    case resource.role
    when "owner"
      resource.barbershop ? root_path : new_barbershop_path
    else
      root_path
    end
  end
end
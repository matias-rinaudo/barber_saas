class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :role, :barbershop_id])
    devise_parameter_sanitizer.permit(:account_update, keys: [:name, :role, :barbershop_id])
  end

  def after_sign_in_path_for(resource)
    case params[:role]
    when "owner"
      new_barbershop_path
    when "barber"
      dashboard_barber_path # ej. tu panel de barberos
    when "customer"
      root_path # o página de clientes
    else
      super
    end
  end
end
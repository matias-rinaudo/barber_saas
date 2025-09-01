# frozen_string_literal: true

# app/controllers/users/registrations_controller.rb
class Users::RegistrationsController < Devise::RegistrationsController
  def create
    super do |user|
      case user.role
      when "owner"
        # Al registrarse un propietario, lo redirigimos a crear su barbería
        flash[:notice] = "Bienvenido propietario, ahora crea tu barbería 🚀"
      when "barber"
        # Ya tiene barber por default
        flash[:notice] = "Bienvenido barbero, selecciona tu barbería."
      when "customer"
        flash[:notice] = "Bienvenido cliente, ya puedes reservar turnos."
      end
    end
  end

  protected

  def after_sign_up_path_for(resource)
    case resource.role
    when "owner"
      new_barbershop_path  # redirige al form de crear barbería
    when "barber"
      edit_user_registration_path  # donde puede elegir barbería
    when "customer"
      root_path  # o página de cliente
    else
      super(resource)
    end
  end
end

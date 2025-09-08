# frozen_string_literal: true

# app/controllers/users/registrations_controller.rb
# frozen_string_literal: true
# app/controllers/users/registrations_controller.rb
class Users::RegistrationsController < Devise::RegistrationsController
  def create
    super do |user|
      if user.persisted?
        case user.role
        when "owner"
          flash[:notice] = "Bienvenido propietario, ahora crea tu barbería 🚀"
        when "barber"
          flash[:notice] = "Bienvenido barbero, selecciona tu barbería."
        when "customer"
          flash[:notice] = "Bienvenido cliente, ya puedes reservar turnos."
        end
      end
    end
  end

  protected

  def after_sign_up_path_for(resource)
    case resource.role
    when "owner"
      new_barbershop_path
    when "barber"
      edit_user_registration_path 
    when "customer"
      root_path
    else
      super(resource)
    end
  end

  def after_update_path_for(resource)
    case resource.role
    when "owner"
      resource.barbershop ? barbershop_path(resource.barbershop) : new_barbershop_path
    when "barber"
      root_path
    when "customer"
      root_path
    else
      super(resource)
    end
  end
end
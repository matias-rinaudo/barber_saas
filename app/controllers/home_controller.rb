class HomeController < ApplicationController
  def index
    if user_signed_in?
      redirect_to dashboard_path_for(current_user)
    end
  end

  private

  def dashboard_path_for(user)
    case user.role
    when 'super_admin'
      super_admin_dashboards_path
    when 'owner'
      owner_dashboards_path
    when 'barber'
      barber_dashboards_path
    when 'customer'
      customer_dashboards_path
    else
      root_path
    end
  end
end

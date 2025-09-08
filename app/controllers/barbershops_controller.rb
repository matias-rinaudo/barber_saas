class BarbershopsController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_owner_role, only: [:new, :create]
  before_action :set_barbershop, only: [:show, :edit, :update, :destroy]
  before_action :ensure_barbershop_owner, only: [:show, :edit, :update, :destroy]

  def index
    @barbershops = current_user.owner? ? [current_user.barbershop].compact : []
  end

  def show
    @branches = @barbershop.branches.active
    @recent_appointments = @barbershop.all_appointments.limit(10)
  end

  def new
    @barbershop = Barbershop.new
  end

  def create
    @barbershop = Barbershop.new(barbershop_params)
    
    if @barbershop.save
      current_user.update(barbershop: @barbershop)
      
      redirect_to @barbershop, notice: '¡Barbería creada exitosamente! 🎉'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @barbershop.update(barbershop_params)
      redirect_to @barbershop, notice: 'Barbería actualizada exitosamente.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @barbershop.destroy
    current_user.update(barbershop: nil)
    redirect_to root_path, notice: 'Barbería eliminada exitosamente.'
  end

  private

  def set_barbershop
    @barbershop = Barbershop.find(params[:id])
  end

  def barbershop_params
    params.require(:barbershop).permit(
      :name, 
      :email, 
      :phone, 
      :address
    )
  end

  def ensure_owner_role
    unless current_user.owner?
      redirect_to root_path, alert: 'No tienes permisos para crear una barbería.'
    end
  end

  def ensure_barbershop_owner
    unless current_user.barbershop == @barbershop
      redirect_to root_path, alert: 'No tienes permisos para acceder a esta barbería.'
    end
  end
end
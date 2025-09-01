class BranchBarbersController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_owner_or_admin
  before_action :set_barbershop
  before_action :set_branch
  
  # GET /barbershops/:barbershop_id/branches/:branch_id/barbers
  def index
    @branch_barbers = @branch.barbers.includes(:user)
    @available_barbers = @barbershop.barbers.where.not(id: @branch.barber_ids)
  end
  
  # POST /barbershops/:barbershop_id/branches/:branch_id/barbers
  def create
    @barber = @barbershop.barbers.find(params[:barber_id])
    
    if @barber.add_branch(@branch)
      redirect_to barbershop_branch_barbers_path(@barbershop, @branch),
                  notice: "Barbero asignado exitosamente a la sucursal"
    else
      redirect_to barbershop_branch_barbers_path(@barbershop, @branch),
                  alert: "Error al asignar barbero a la sucursal"
    end
  end
  
  # DELETE /barbershops/:barbershop_id/branches/:branch_id/barbers/:id
  def destroy
    @barber = @branch.barbers.find(params[:id])
    
    # Verificar que el barbero tenga al menos una sucursal asignada
    if @barber.branches.count <= 1
      redirect_to barbershop_branch_barbers_path(@barbershop, @branch),
                  alert: "El barbero debe tener al menos una sucursal asignada"
      return
    end
    
    @barber.remove_branch(@branch)
    redirect_to barbershop_branch_barbers_path(@barbershop, @branch),
                notice: "Barbero removido de la sucursal"
  end
  
  private
  
  def set_barbershop
    @barbershop = current_user.barbershop
  end
  
  def set_branch
    @branch = @barbershop.branches.find(params[:branch_id])
  end
  
  def ensure_owner_or_admin
    unless current_user.owner? || current_user.super_admin?
      redirect_to root_path, alert: "No tienes permisos para realizar esta acción"
    end
  end
end
class BranchesController < ApplicationController
  before_action :set_barbershop
  before_action :set_branch, only: [:show, :edit, :update, :destroy, :reports]

  def index
    @branches = @barbershop.branches.order(:name).page(params[:page]).per(9) # 9 por página
  end

  def show; end

  def new
    @branch = @barbershop.branches.build
  end

  def create
    debugger
    @branch = @barbershop.branches.build(branch_params)

    if @branch.save
      redirect_to barbershop_branches_path(@barbershop), notice: "Sucursal creada correctamente."
    else
      flash.now[:alert] = "No se pudo crear la sucursal."
      render :new
    end
  end

  def edit; end

  def update
    if @branch.update(branch_params)
      redirect_to barbershop_branch_path(@barbershop, @branch), notice: "Sucursal actualizada correctamente."
    else
      flash.now[:alert] = "No se pudo actualizar la sucursal."
      render :edit
    end
  end

  def destroy
    @branch.destroy
    redirect_to barbershop_branches_path(@barbershop), notice: "Sucursal eliminada correctamente."
  end

  def reports
  end

  private

  def set_barbershop
    @barbershop = Barbershop.find(params[:barbershop_id])
  end

  def set_branch
    @branch = @barbershop.branches.find(params[:id])
  end

  def branch_params
    params.require(:branch).permit(
      :name,
      :address,
      :phone,
      :active,
      :description, :email)
  end
end

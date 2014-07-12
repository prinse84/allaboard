class VendorsController < ApplicationController
  
  before_action :authenticate_user!, :only => [:create, :update, :destroy]
  
  def index
    @vendors = Vendor.all.paginate(:page => params[:page], :per_page => 20).order('name')
  end
  
  def show
    @vendor = Vendor.find(params[:id])
  end
  
  def new
    @vendor = Vendor.new
  end
  
  def create
    @vendor = Vendor.new(vendor_params)
    if @vendor.save
      flash[:success] = "Vendor added to directory."
      redirect_to vendor_path(@vendor)
    else
      render 'new'
    end
  end

  def edit
    @vendor = Vendor.find(params[:id])
  end

  def update
    @vendor = Vendor.find(params[:id])
    if @vendor.update_attributes(vendor_params)
      flash[:success] = "Vendor updated"
      redirect_to @vendor
    else
      render 'edit'
    end
  end

  def destroy
    Vendor.find(params[:id]).destroy
    flash[:success] = "The vendor has been deleted."
    redirect_to vendors_path
  end
  
  private
    def vendor_params
      params.require(:vendor).permit(:name, :address, :phone, :email, :contact, :board_id)
    end
    
    def suggestion_params
      params.require(:suggestion).permit(:suggested_vendor_name, :suggester_email)
    end

end

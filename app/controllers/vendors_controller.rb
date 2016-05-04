class VendorsController < ApplicationController

  before_action :authenticate_user!, :only => [:new, :create, :edit, :update, :destroy]
  before_action :user_owns_board, :only => [:new, :create]
  before_action :user_owns_this_vendor, :only => [:edit, :update, :destroy]

  def index
    @vendors = Vendor.all.paginate(:page => params[:page], :per_page => 20).order('name')
  end

  # Show action. This will respond to /vendors/:id
  def show
    # Check to see that a valid vendor id was sent in. If not, redirect to vendors index page
    if @vendor = Vendor.find_by(id: params[:id])
      # A valid vendor was passed via :id
      # get all reviews associated with this vendor
      @reviews = @vendor.vendor_reviews.paginate(:page => params[:page], :per_page => 5).order('created_at DESC')
    else
      flash[:warning] = "The vendor you are looking for does not exist"
      redirect_to vendors_path
    end
  end

  def new
    @vendor = Vendor.new
    @all_boards = Board.all
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
    @all_boards = Board.all
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
      params.require(:vendor).permit(:name, :address, :phone, :email, :contact, :board_id, :outdoor, :indoor, :capacity, :cost, :food, :catering, :website_url)
    end

    def suggestion_params
      params.require(:suggestion).permit(:suggested_vendor_name, :suggester_email)
    end

    def user_owns_board
      if current_user.admin
        return
      end
      if current_user.boards.blank?
        flash[:failure] = "You can only do that if you manage a board."
        redirect_to vendors_path
      end
    end

    def user_owns_this_vendor
      if current_user.admin
        return
      end
      @vendor = Vendor.find(params[:id])
      @board = current_user.boards.find(@vendor.board_id)
      if @board.nil?
        flash[:failure] = "You can only do that if you own this vendor."
        redirect_to vendors_path
      end
    end

end

class VendorReviewsController < ApplicationController
  before_action :admin_user, :only => [:edit, :update, :destroy]

  def new
    @review = VendorReview.new(:vendor_id =>params[:vendor_id])
  end

  def create
    @review = VendorReview.new(review_params)
    @review.rating = params[:score]
    if @review.save
      flash[:success] = "Review saved."
      redirect_to vendor_path(@review.vendor)
    else
      render 'new'
    end
  end

  def edit
    @review = VendorReview.find(params[:id])
  end

  def update
    @review = VendorReview.find(params[:id])
    @review.rating = params[:score]
    if @review.update_attributes(review_params)
      flash[:success] = "Review updated"
      redirect_to vendor_path(@review.vendor)
    else
      render 'edit'
    end
  end

  def destroy
    @review = VendorReview.find(params[:id])
    @vendor = @review.vendor
    @review.destroy
    flash[:success] = "The review has been deleted."
    redirect_to vendor_path(@vendor)
  end

  private

    def review_params
      params.require(:vendor_review).permit(:title, :pros, :cons, :vendor_id)
    end

    def admin_user
      return current_user.admin
    end

end

class VendorReviewsController < ApplicationController

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

  private

    def review_params
      params.require(:vendor_review).permit(:title, :pros, :cons, :vendor_id)
    end

end

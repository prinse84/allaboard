class VendorReviewsController < ApplicationController

  def new
    @review = VendorReview.new(:vendor_id =>params[:vendor_id])
  end

end

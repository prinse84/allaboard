class StaticPagesController < ApplicationController
  def home
    @reviews = Review.all
  end

  def help
  end
end

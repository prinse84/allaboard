class StaticPagesController < ApplicationController
  def home
    @reviews = Review.all.limit(5)
  end

  def help
  end
end

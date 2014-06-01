class StaticPagesController < ApplicationController
  def home
    @reviews = Review.all
    @boards = Board.all.limit(5).order('created_at DESC')
  end

  def help
  end
end

class StaticPagesController < ApplicationController
  def home
    @reviews = Review.all
    ids = Review.pluck(:board_id).shuffle[0..2]
    @boards = Board.where(id: ids)
  end

  def help
  end
end

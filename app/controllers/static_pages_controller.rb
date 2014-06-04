class StaticPagesController < ApplicationController
  def home
    @reviews = Review.all
    
    #Get 5 random boards
    ids = Board.pluck(:id).shuffle[0..4]
    @boards = Board.where(id: ids)
    
  end

  def help
  end
end

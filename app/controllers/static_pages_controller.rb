class StaticPagesController < ApplicationController
  def home
    @reviews = Review.all
    ids = Review.pluck(:board_id).shuffle[0..1]
    @boards = Board.where(id: ids)
    @events = Event.where("date >= ?", Time.now).order('date').limit(7)
  end
end

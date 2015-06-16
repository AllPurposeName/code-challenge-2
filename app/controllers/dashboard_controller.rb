class DashboardController < ApplicationController

  def index
    @boards = Board.all
  end
end

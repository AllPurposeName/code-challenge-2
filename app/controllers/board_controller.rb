class BoardController < ApplicationController

  def index
    @boards = Board.all
  end

  def show

  end
end

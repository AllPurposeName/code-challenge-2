class BoardController < ApplicationController

  def index
    @boards = Board.all
  end

  def show
    board = Board.find_by(id: params[:board_id])
    @tickets = board.tickets
  end

  def create
    board = Board.new(title: params[:Title])
    if board.save
      flash[:complete] = "Board created successfully"
    else
      flash[:alert] = "Board needs a title"
    end
    redirect_to root_path
  end
end

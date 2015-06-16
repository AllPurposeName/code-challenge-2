class TicketsController < ApplicationController

  def create
    board = Board.find_by(id: Rails.application.routes.recognize_path(request.referrer)[:board_id])
    ticket = board.tickets.new(title: params[:Title])
    ticket.save

    redirect_to :back
  end
end

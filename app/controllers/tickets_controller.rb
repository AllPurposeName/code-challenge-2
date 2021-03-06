class TicketsController < ApplicationController

  def create
    board = Board.find_by(id: Rails.application.routes.recognize_path(request.referrer)[:board_id])
    ticket = board.tickets.new(title: params[:Title], status: params[:status], description: params[:description])
    ticket.save

    redirect_to :back
  end

  def update
    ticket = Ticket.find_by(id: params[:format])
    ticket.update(status: params[:status])
    redirect_to :back
  end
end

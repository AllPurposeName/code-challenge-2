require "test_helper"
class SectionedTicketsDecoratorTest < ActiveSupport::TestCase
  attr_reader :board, :ticket1,
    :ticket2, :ticket3,
    :ticket4, :ticket5,
    :ticket6, :ticket7,
    :ticket8, :ticket9

  def setup
    @board = Board.create!(title: "Dinner Dash")
    @ticket1 = board.tickets.create!(title: "1", status: "Done")
    @ticket2 = board.tickets.create!(title: "2", status: "Done")
    @ticket3 = board.tickets.create!(title: "3", status: "Done")
    @ticket4 = board.tickets.create!(title: "4", status: "Backlog")
    @ticket5 = board.tickets.create!(title: "5", status: "Backlog")
    @ticket6 = board.tickets.create!(title: "6", status: "In Progress")
    @ticket7 = board.tickets.create!(title: "7", status: "Current Sprint")
    @ticket8 = board.tickets.create!(title: "8", status: "Current Sprint")
    @ticket9 = board.tickets.create!(title: "9", status: "Current Sprint")
  end

  def test_it_knows_which_ticket_has_which_status
    draper = SectionedTicketsDecorator.decorate_collection(board.tickets)

    assert draper.first.done_link
    refute draper.first.in_progress_link
    assert_equal ticket2.title, draper.second.done_title
  end

  def test_it_grabs_only_the_backlogged
    skip
    draper = SectionedTicketsDecorator.decorate_collection(board.tickets)

    assert_equal [ticket4, ticket5], draper.backlog
  end
end

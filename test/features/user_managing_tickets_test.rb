require "test_helper"

class UserManagingTicketsTest < ActiveSupport::TestCase

  def test_there_are_a_list_of_boards_to_choose_from
    board1 = Board.create!(title: "Dinner Dash")
    board2 = Board.create!(title: "The Pivot")
    visit '/'

    within("#boards") do
      assert page.has_content?(board1.title), "the first board's title should appear"
      assert page.has_content?(board2.title), "the second board's title should appear"
    end
  end
end

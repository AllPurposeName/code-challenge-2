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

  def test_a_board_has_four_sections_for_tickets
    board = Board.create!(title: "Dinner Dash")
    expected_sections = ["Backlog", "Current Sprint", "In Progress", "Done"]

    visit '/'
    click_link_or_button(board.title)
    assert_equal "/#{board.id}", current_path
    expected_sections.each do |section|
      assert page.has_content?(section), "section: #{section} should appear in a column"
    end
  end

  def test_user_can_create_a_board
    visit '/'
    fill_in "Title", with: "Re-Pivot"
    assert_difference("Board.count", 1) do
      click_link_or_button("Submit")
    end
    assert page.has_content?("Board created successfully"), "flash message should appear"
    assert page.has_link?("Re-Pivot"), "link to the new board should be present"
  end
end

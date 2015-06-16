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

  def test_a_board_has_tickets_a_user_can_view
    board = Board.create!(title: "Dinner Dash")
    ticket = board.tickets.create!(title: "Do all the things", description: "do it faster", status: "In Progress")

    visit "/#{board.id}"
    assert page.has_content?(ticket.title), "it should display the ticket's title #{ticket.title}"
  end

  def test_a_board_only_displays_its_tickets
    board = Board.create!(title: "Dinner Dash")
    board2 = Board.create!(title: "The Pivot")
    ticket = board2.tickets.create!(title: "Do all the things", description: "do it faster", status: "In Progress")

    visit "/#{board2.id}"
    assert page.has_content?(ticket.title), "board 2 should display the ticket normally"

    visit "/#{board.id}"
    refute page.has_content?(ticket.title), "board one should not have access to the ticket"
  end

  def test_a_user_can_create_a_ticket_on_a_board
    board = Board.create!(title: "PokeTeam")

    visit "/#{board.id}"
    fill_in "Title", with: "Make Angular Work!"
    assert_difference("Ticket.count", 1) do
      click_link_or_button("Submit")
    end
    assert_equal "/#{board.id}", current_path
    assert page.has_content?("Make Angular Work!"), "ticket should appear on the board page"
  end
end

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

  def test_a_ticket_created_with_optional_fields_saves_normally
    board = Board.create!(title: "Reader-Meter")

    visit "/#{board.id}"
    fill_in "Title", with: "Don't pivot pls"
    fill_in "description", with: "Pivoting is so rough"
    select "In Progress", from: "status"
    assert_difference("Ticket.count", 1) do
      click_link_or_button("Submit")
    end
    within("#in-progress") do
      assert page.has_content?("Don't pivot pls"), "ticket should still appear on the board page under the appropriate status"
    end
  end

  def test_tickets_only_appear_in_the_section_matching_their_status
    board = Board.create!(title: "Code Challenge 2")

    ticket1 = board.tickets.create!(title: "Creating/Viewing Boards", status: "Done")
    ticket2 = board.tickets.create!(title: "Creating/Viewing Tickets", status: "Done")
    ticket3 = board.tickets.create!(title: "Manipulating Tickets", status: "In Progress")

    visit "/#{board.id}"

    within("#done") do
      assert page.has_content?(ticket1.title), "the first two tickets should appear in Done"
      assert page.has_content?(ticket2.title), "the first two tickets should appear in Done"
      refute page.has_content?(ticket3.title), "the third ticket should NOT appear in Done"
    end
    within("#in-progress") do
      refute page.has_content?(ticket1.title), "the first two tickets should NOT appear in In Progress"
      refute page.has_content?(ticket2.title), "the first two tickets should NOT appear in In Progress"
      assert page.has_content?(ticket3.title), "the first two tickets should appear in In Progress"
    end
  end

  def test_a_ticket_can_change_sections
    board = Board.create!(title: "Code Challenge 2")

    ticket = board.tickets.create!(title: "Manipulating Tickets", status: "In Progress")

    visit "/#{board.id}"

    within("#current-sprint") do
      refute page.has_content?(ticket.title), "ticket should have moved statuses"
    end
    within("#in-progress") do
      click_link_or_button("Move to Current Sprint")
    end
    within("#current-sprint") do
      assert page.has_content?(ticket.title), "ticket should have moved statuses"
    end
  end
end

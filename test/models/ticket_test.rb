require 'test_helper'

class TicketTest < ActiveSupport::TestCase

  def test_it_requires_a_title
    ticket = Ticket.new
    ticket_with_title = Ticket.new(title: "Heyyo")

    refute ticket.save
    assert ticket_with_title.save
  end
end

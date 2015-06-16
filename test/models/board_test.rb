require 'test_helper'

class BoardTest < ActiveSupport::TestCase

  def test_it_requires_a_title
    board = Board.new
    board_with_title = Board.new(title: "Hello World")

    refute board.save
    assert board_with_title.save
  end
end

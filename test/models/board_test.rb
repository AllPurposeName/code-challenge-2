require 'test_helper'

class BoardTest < ActiveSupport::TestCase

  def test_it_requires_a_title
    refute Board.new.valid?
    assert Board.new(title: "Hello World").valid?
  end
end

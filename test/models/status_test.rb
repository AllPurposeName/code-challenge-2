require 'minitest/spec'
require 'minitest/autorun'
require 'minitest/pride'

require_relative '../../app/models/status'

class TestStatus < Minitest::Spec
  FakeTicket = Struct.new(:status)

  it 'has statuses for Backlog, Current Sprint, In Progress, Done' do
    assert_equal ["Backlog", "Current Sprint", "In Progress", "Done"],
                 Status.names
  end

  it 'groups statusable things by their status' do
    tickets = [
      FakeTicket.new('Backlog'),
      FakeTicket.new('Current Sprint'),
      FakeTicket.new('Backlog'),
    ]

    assert_equal Status.names, Status.groups_for(tickets).keys.map(&:name)

    assert_equal [
      [FakeTicket.new('Backlog'), FakeTicket.new('Backlog')],
      [FakeTicket.new('Current Sprint')],
      [],
      []
    ], Status.groups_for(tickets).values
  end

  it 'knows the status order' do
    status = Status.new("b", ["a", "b", "c"])
    assert_equal "a", status.prev_status
    assert_equal "c", status.next_status
  end

  it 'knows if the status has a previous status' do
    refute Status.new("a", ["a", "b"]).has_prev?
    assert Status.new("b", ["a", "b"]).has_prev?
  end

  it 'knows if the status has a next status' do
    assert Status.new("a", ["a", "b"]).has_next?
    refute Status.new("b", ["a", "b"]).has_next?
  end

  it 'sets the css id to be the downcased, dasherized name' do
    assert_equal "abc-def-ghi", Status.new("Abc DEF ghi", ["Abc DEF ghi", "b"]).css_id
  end
end

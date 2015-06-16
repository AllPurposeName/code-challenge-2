class Status
  def self.names
    @names ||= ["Backlog", "Current Sprint", "In Progress", "Done"].map(&:freeze).freeze
  end

  def self.groups_for(tickets)
    grouped_by_name = names.map { |name| [name, []] }.to_h
    tickets.each { |ticket| grouped_by_name[ticket.status] << ticket }
    grouped_by_name.map { |name, tickets| [new(name, names), tickets] }.to_h
  end

  attr_accessor :name, :names

  def initialize(name, names)
    self.name  = name
    self.names = names
  end

  def has_prev?
    !index.zero?
  end

  def has_next?
    index < max_index
  end

  def prev_status
    names[index.pred] if has_prev?
  end

  def next_status
    names[index.succ] if has_next?
  end

  def display_name
    name
  end

  def css_id
    name.downcase.gsub(' ', '-')
  end

  private

  def index
    names.index name
  end

  def max_index
    names.length.pred
  end
end

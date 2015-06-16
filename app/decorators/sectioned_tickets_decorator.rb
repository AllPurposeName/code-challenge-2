class SectionedTicketsDecorator < Draper::Decorator
  decorates :ticket
  delegate_all
  def backlog_title
    title if status == "Backlog"
  end
  def backlog_link
    status == "Backlog"
  end

  def done_title
    title if status == "Done"
  end
  def done_link
    status == "Done"
  end

  def current_sprint_title
    title if status == "Current Sprint"
  end
  def current_sprint_link
    status == "Current Sprint"
  end

  def in_progress_title
    title if status == "In Progress"
  end
  def in_progress_link
    status == "In Progress"
  end
end

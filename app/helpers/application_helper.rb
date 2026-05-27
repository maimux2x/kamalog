module ApplicationHelper
  def status_badge_class(status)
    case status
    when 'in_progress'
      'text-bg-secondary'
    when 'complete'
      'text-bg-success'
    end
  end
end

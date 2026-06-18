module ApplicationHelper
  def status_badge_class(status)
    case status
    when 'in_progress'
      'text-bg-secondary'
    when 'complete'
      'text-bg-success'
    end
  end

  def login_url(provider)
    url       = URI.parse("/auth/#{provider}")
    url.query = URI.encode_www_form([['origin', flash[:origin]]]) if flash[:origin]

    url.to_s
  end
end

module ApplicationHelper
  include ActiveSupport::NumberHelper

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

  def clay_weight(usage)
    "#{number_to_rounded(usage.weight_amount, strip_insignificant_zeros: true)}#{usage.weight_unit_i18n}"
  end
end

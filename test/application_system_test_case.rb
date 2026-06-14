require 'test_helper'
require 'capybara/minitest'
require 'capybara/simulated'

Capybara.configure do |config|
  config.enable_aria_label = true
end

class ApplicationSystemTestCase < ActionDispatch::SystemTestCase
  driven_by :simulated

  include SignInHelper

  def self.driven_by_selenium
    driven_by :selenium, using: :headless_chrome, screen_size: [1400, 1400]
  end
end

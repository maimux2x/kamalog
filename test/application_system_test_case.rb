require 'test_helper'
require 'capybara/minitest'
require 'capybara/simulated'

Capybara.configure do |config|
  config.enable_aria_label = true
end

class ApplicationSystemTestCase < ActionDispatch::SystemTestCase
  driven_by :rack_test

  include SignInHelper

  def self.driven_by_simulated
    driven_by :simulated
  end
end

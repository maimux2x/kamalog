require 'test_helper'

class ApplicationSystemTestCase < ActionDispatch::SystemTestCase
  driven_by :rack_test

  include SignInHelper

  def self.driven_by_selenium
    driven_by :selenium, using: :headless_chrome, screen_size: [1400, 1400]
  end
end

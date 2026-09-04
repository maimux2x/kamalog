require 'application_system_test_case'

class LoginTest < ApplicationSystemTestCase
  setup do
    OmniAuth.config.mock_auth[:google_oauth2] = OmniAuth::AuthHash.new(
      provider: 'google_oauth2',
      uid:      '12345',

      info: {
        name:  'Alice',
        email: 'alice@example.com'
      }
    )
  end

  teardown do
    OmniAuth.config.mock_auth[:google_oauth2] = nil
  end

  test 'ログインすると教室一覧が表示される' do
    visit root_path

    click_on 'Google アカウントでログイン'

    assert_text 'ログインしました。'
    assert_text '所属教室'
  end
end

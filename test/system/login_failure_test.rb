require 'application_system_test_case'

class LoginFailureTest < ApplicationSystemTestCase
  setup do
    OmniAuth.config.mock_auth[:google_oauth2] = :invalid_credentials
  end

  teardown do
    OmniAuth.config.mock_auth[:google_oauth2] = nil
  end

  test '認証に失敗するとログイン画面へリダイレクトする' do
    visit root_path

    click_on 'Google アカウントでログイン'

    assert_text '認証に失敗しました。時間を置いて再度お試しください。'
    assert_button 'Google アカウントでログイン'
  end
end

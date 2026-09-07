require 'application_system_test_case'

class LoginFailureTest < ApplicationSystemTestCase
  test '認証に失敗するとログイン画面へリダイレクトする' do
    visit root_path

    mock_failure_auth do
      click_on 'Google アカウントでログイン'
    end

    assert_text '認証に失敗しました。時間を置いて再度お試しください。'
    assert_button 'Google アカウントでログイン'
  end
end

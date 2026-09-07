require 'application_system_test_case'

class LoginTest < ApplicationSystemTestCase
  test 'ログインすると教室一覧が表示される' do
    visit root_path

    mock_auth users(:alice) do
      click_on 'Google アカウントでログイン'
    end

    assert_text 'ログインしました。'
    assert_text '所属教室'
  end
end

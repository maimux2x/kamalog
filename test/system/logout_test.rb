require 'application_system_test_case'

class LogoutTest < ApplicationSystemTestCase
  driven_by_simulated

  test 'ログアウトするとログイン画面が表示される' do
    visit root_path

    mock_auth users(:alice) do
      click_on 'Google アカウントでログイン'
    end

    click_on 'Alice'
    click_on 'ログアウト'

    assert_text 'ログアウトしました。'
    assert_button 'Google アカウントでログイン'
  end
end

require 'application_system_test_case'

class LogoutTest < ApplicationSystemTestCase
  driven_by_simulated

  test 'ログアウトするとログイン画面が表示される' do
    visit root_path
    sign_in_as users(:alice)

    click_on 'Alice'
    click_on 'ログアウト'

    assert_text 'ログアウトしました。'
    assert_button 'Google アカウントでログイン'
  end
end

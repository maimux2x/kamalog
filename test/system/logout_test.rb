require 'application_system_test_case'

class LogoutTest < ApplicationSystemTestCase
  test 'ログアウトするとログイン画面が表示される' do
    visit root_path

    mock_auth users(:alice) do
      click_on 'Google で続ける'
    end

    assert_text 'ログインしました。'

    click_on 'ログアウト'

    assert_text 'ログアウトしました。'
    assert_button 'Google で続ける'
  end
end

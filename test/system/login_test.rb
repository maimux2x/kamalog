require 'application_system_test_case'

class LoginTest < ApplicationSystemTestCase
  test '教室に所属している場合ログインすると作品一覧が表示される' do
    visit root_path

    mock_auth users(:alice) do
      click_on 'Google で続ける'
    end

    assert_text 'ログインしました。'
    assert_link '作品を登録'
  end

  test '教室に所属していない場合メッセージが表示される' do
    visit root_path

    mock_auth users(:ben) do
      click_on 'Google で続ける'
    end

    assert_text 'ログインしました。'
    assert_text 'まだ教室に参加していません'
  end
end

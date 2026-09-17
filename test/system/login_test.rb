require 'application_system_test_case'

class LoginTest < ApplicationSystemTestCase
  test '複数の教室に所属していて、最後に見ていた教室がない場合ログインすると最初に参加した教室の作品一覧が表示される' do
    visit root_path

    mock_auth users(:alice) do
      click_on 'Google で続ける'
    end

    assert_text 'ログインしました。'
    assert_current_path studio_my_pieces_path(studios(:mirrorland))
  end

  test '複数の教室に所属していて、最後に見ていた教室がある場合、その教室の作品一覧が表示される' do
    users(:alice).update! last_seen_studio: studios(:wonderland)

    visit root_path

    mock_auth users(:alice) do
      click_on 'Google で続ける'
    end

    assert_text 'ログインしました。'
    assert_current_path studio_my_pieces_path(studios(:wonderland))
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

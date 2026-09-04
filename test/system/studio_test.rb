require 'application_system_test_case'

class StudioTest < ApplicationSystemTestCase
  test '所属教室が表示されること' do
    visit root_path

    mock_auth users(:bob) do
      click_on 'Google アカウントでログイン'
    end

    assert_text 'ログインしました。'

    assert_link 'ワンダーランド教室'
    assert_link 'ミラーランド教室'
  end

  test '教室を作成できること' do
    visit root_path

    mock_auth users(:bob) do
      click_on 'Google アカウントでログイン'
    end

    assert_text 'ログインしました。'

    visit new_studio_path

    fill_in '名前', with: 'ドリームランド教室'

    click_on '作成する'

    assert_text '教室を作成しました。'

    click_on '設定'
    click_on 'メンバー'

    within '.list-group-item', text: 'Bob' do
      assert_select 'membership[role]', selected: '管理者', disabled: true
    end
  end

  test 'どこの教室にも所属していないメッセージが表示されること' do
    visit root_path

    mock_auth users(:ben) do
      click_on 'Google アカウントでログイン'
    end

    assert_text 'ログインしました。'
    assert_text '教室から招待を受けるか新しい教室を作成してください。'
  end
end

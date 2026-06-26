require 'application_system_test_case'

class StudioTest < ApplicationSystemTestCase
  test '所属教室が表示されること' do
    visit root_path
    sign_in_as users(:bob)

    assert_link 'ワンダーランド教室'
    assert_link 'ミラーランド教室'
  end

  test '教室を作成できること' do
    visit root_path
    sign_in_as users(:bob)
    visit new_studio_path

    fill_in '名前', with: 'ドリームランド教室'

    click_on '登録する'

    assert_text '教室を作成しました。'
    assert_text 'ドリームランド教室'
  end

  test 'どこの教室にも所属していないメッセージが表示されること' do
    visit root_path
    sign_in_as users(:ben)

    assert_text '教室から招待を受けるか新しい教室を作成してください。'
  end
end

require 'application_system_test_case'

class PiecesTest < ApplicationSystemTestCase
  setup do
    sign_in_as users(:alice)
  end

  test '製作中一覧を表示する' do
    visit my_in_progress_index_path

    assert_link 'マグカップ'
    assert_link '花瓶'
  end

  test '詳細を表示する' do
    visit my_piece_path(pieces(:cup))

    assert_text 'マグカップ'
  end

  test '作品を削除する' do
    visit my_piece_path(pieces(:cup))

    click_on '削除'

    assert_text '製作中の作品を削除しました。'
    assert_no_link 'マグカップ'
    assert_link '花瓶'
  end
end

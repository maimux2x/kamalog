require 'application_system_test_case'

class My::PiecesTest < ApplicationSystemTestCase
  setup do
    sign_in_as users(:alice)
  end

  test '作品一覧を表示する' do
    visit studio_my_pieces_path(studios(:wonderland))

    assert_link 'マグカップ'
    assert_link '花瓶'
  end

  test '詳細を表示する' do
    visit studio_my_piece_path(studios(:wonderland), pieces(:cup))

    assert_text 'マグカップ'
  end

  test '作品を削除する' do
    visit studio_my_piece_path(studios(:wonderland), pieces(:cup))

    click_on '削除'

    assert_text '製作中の作品を削除しました。'
    assert_no_link 'マグカップ'
    assert_link '花瓶'
  end
end

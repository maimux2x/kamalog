require 'application_system_test_case'

class My::PiecesTest < ApplicationSystemTestCase
  setup do
    @studio = studios(:wonderland)
    @piece  = pieces(:cup)

    visit root_path

    mock_auth users(:alice) do
      click_on 'Google アカウントでログイン'
    end

    assert_text 'ログインしました。'
  end

  test '自分の作品を表示する' do
    visit studio_my_pieces_path(@studio)

    assert_link 'マグカップ'
    assert_link '花瓶'
  end

  test '詳細を表示する' do
    visit studio_my_piece_path(@studio, @piece)

    assert_text 'マグカップ'
  end

  test '作品を削除する' do
    visit studio_my_piece_path(@studio, @piece)

    click_on '削除'

    assert_text '製作中の作品を削除しました。'
    assert_no_link 'マグカップ'
    assert_link '花瓶'
  end
end

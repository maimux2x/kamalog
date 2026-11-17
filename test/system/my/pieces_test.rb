require 'application_system_test_case'

class My::PiecesTest < ApplicationSystemTestCase
  setup do
    @studio = studios(:wonderland)
    @piece  = pieces(:cup)

    visit root_path

    mock_auth users(:alice) do
      click_on 'Google で続ける'
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
    assert_text '好きな作家さんの作風を参考に作ってみる。'
  end

  test '作品を削除する' do
    visit studio_my_piece_path(@studio, @piece)

    click_on '削除'

    assert_text '製作中の作品を削除しました。'
    assert_no_link 'マグカップ'
    assert_link '花瓶'
  end

  test '作業記録を削除する' do
    visit studio_my_piece_path(@studio, @piece)

    within 'div.kml-log', text: '2026-04-05' do
      click_on 'この記録を削除'
    end

    assert_text '作業記録を削除しました。'

    assert_no_text '2026-04-05'
    assert_no_text '好きな作家さんの作風を参考に作ってみる。'

    assert_text '2026-04-12'
    assert_text '削りを入れて凹凸や底の厚みを削って形を整えた。'
  end
end

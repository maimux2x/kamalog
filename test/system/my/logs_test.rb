require 'application_system_test_case'

class My::LogsTest < ApplicationSystemTestCase
  setup do
    visit root_path
    sign_in_as users(:alice)

    @studio = users(:alice).studios.first
    @piece  = pieces(:cup)
  end

  test '作業記録を表示できること' do
    visit studio_my_piece_path(@studio, @piece)

    click_on '作業記録'

    assert_text '2026-04-05'
    assert_text '紐作りでマグカップ作り'
    assert_text '好きな作家さんの作風を参考に作ってみる。'

    assert_text '2026-04-12'
    assert_text '削りで形を整える'
    assert_text '削りを入れて凹凸や底の厚みを削って形を整えた。'
  end

  test '詳細を表示する' do
    visit studio_my_piece_logs_path(@studio, @piece)

    click_on '紐作りでマグカップ作り'

    assert_text '2026-04-05'
    assert_text '紐作りでマグカップ作り'
    assert_text '好きな作家さんの作風を参考に作ってみる。'
    assert_selector "img[src$='/dish_cup.png']"
  end

  test 'タイトルを入力しないと登録できない' do
    visit studio_my_piece_logs_path(@studio, @piece)

    click_on '作業記録を登録する'

    fill_in '作業日', with: Date.new(2026, 4, 23)

    click_on '登録する'

    assert_text 'を入力してください'
  end

  test '作業記録を削除する' do
    visit studio_my_piece_log_path(@studio, @piece, logs(:cup_log_day1))

    click_on '削除'

    assert_text '作業記録を削除しました。'

    assert_no_text '2026-04-05'
    assert_no_text '紐作りでマグカップ作り'
    assert_no_text '好きな作家さんの作風を参考に作ってみる。'

    assert_text '2026-04-12'
    assert_text '削りで形を整える'
    assert_text '削りを入れて凹凸や底の厚みを削って形を整えた。'
  end
end

require 'application_system_test_case'

class LogsJsTest < ApplicationSystemTestCase
  driven_by_selenium

  setup do
    sign_in_as users(:alice)
  end

  test '作業記録を登録する（キャプションが全て未入力）' do
    visit my_piece_logs_path(pieces(:cup))

    click_on '作業記録を登録する'

    fill_in '作業日',   with: Date.new(2026, 4, 23)
    fill_in 'タイトル', with: '釉がけをして仕上げる'
    fill_in '作業内容', with: '素焼きが終わったマグカップをやすりで削って、白マットの釉薬をかけた。'

    attach_file '画像を追加', [file_fixture('dish_cup.png'), file_fixture('syokki_mug_cup.png'), file_fixture('dish.png')], multiple: true, make_visible: true

    within('[data-attach-images-target="container"] :nth-child(2 of [data-attach-images-target="item"])') do
      click_on '×'
    end

    click_on '登録する'

    assert_text '作業記録を登録しました。'
    assert_text '2026-04-23'
    assert_text '釉がけをして仕上げる'
    assert_text '素焼きが終わったマグカップをやすりで削って、白マットの釉薬をかけた。'
  end

  test '作業記録を登録する（キャプション未入力のフィールドが一つある）' do
    visit my_piece_logs_path(pieces(:cup))

    click_on '作業記録を登録する'

    fill_in '作業日',   with: Date.new(2026, 4, 23)
    fill_in 'タイトル', with: '釉がけをして仕上げる'
    fill_in '作業内容', with: '素焼きが終わったマグカップをやすりで削って、白マットの釉薬をかけた。'

    attach_file '画像を追加', [file_fixture('dish_cup.png'), file_fixture('syokki_mug_cup.png'), file_fixture('dish.png')], multiple: true, make_visible: true

    within('[data-attach-images-target="container"] :nth-child(2 of [data-attach-images-target="item"])') do
      click_on '×'
    end

    within('[data-attach-images-target="container"] :nth-child(1 of [data-attach-images-target="item"])') do
      fill_in '説明', with: '画像の説明'
    end

    click_on '登録する'

    assert_text '作業記録を登録しました。'
    assert_text '2026-04-23'
    assert_text '釉がけをして仕上げる'
    assert_text '素焼きが終わったマグカップをやすりで削って、白マットの釉薬をかけた。'
    assert_text '画像の説明'
  end
  test '作業記録を更新する' do
    visit my_piece_log_path(pieces(:cup), logs(:cup_log_day1))

    click_on '編集'

    fill_in '作業内容', with: '更新後の作業内容'

    click_on '更新する'

    assert_text '作業記録を更新しました。'
    assert_text '2026-04-05'
    assert_text '紐作りでマグカップ作り'
    assert_text '更新後の作業内容'
  end
end

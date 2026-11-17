require 'application_system_test_case'

class My::LogsJsTest < ApplicationSystemTestCase
  driven_by_simulated

  setup do
    @studio = studios(:wonderland)
    @piece  = pieces(:cup)

    visit root_path

    mock_auth users(:alice) do
      click_on 'Google で続ける'
    end

    assert_text 'ログインしました。'
  end

  test '作業記録を登録する' do
    visit studio_my_piece_path(@studio, @piece)

    click_on '＋ 作業記録を追加'

    fill_in '作業日',   with: Date.new(2026, 4, 23)
    check '釉掛け', allow_label_click: true
    select '白マット', from: '釉薬'
    fill_in '作業内容', with: '素焼きが終わったマグカップをやすりで削って、白マットの釉薬をかけた。'
    attach_file '画像を追加', [file_fixture('dish_cup.png'), file_fixture('syokki_mug_cup.png')], make_visible: true

    within '[data-attach-images-target="item"]:first-child' do
      fill_in '説明', with: '釉薬をかけた写真'
    end

    within '[data-attach-images-target="container"] :nth-child(2 of [data-attach-images-target="item"])' do
      click_on '削除'
    end

    click_on '登録する'

    assert_text        '作業記録を登録しました。'
    assert_text        '2026-04-23'
    assert_text        '素焼きが終わったマグカップをやすりで削って、白マットの釉薬をかけた。'
    assert_text        '釉薬をかけた写真'
    assert_selector    'img[src$="/dish_cup.png"]'
    assert_no_selector 'img[src$="/syokki_mug_cup.png"]'
  end

  test '作業記録を更新する' do
    visit studio_my_piece_path(@studio, @piece)

    within 'div.kml-log', text: '2026-04-19' do
      click_on 'この記録を編集'
    end

    fill_in '作業内容', with: '更新後の作業内容'

    assert_no_text '使った釉薬'

    attach_file '画像を追加', file_fixture('syokki_mug_cup.png'), make_visible: true

    within '[data-attach-images-target="container"] :nth-child(1 of [data-attach-images-target="item"])' do
      fill_in '説明', with: '説明を更新'
    end

    within 'footer' do
      click_on '更新する'
    end

    assert_text        '作業記録を更新しました。'
    assert_text        '2026-04-05'
    assert_text        '更新後の作業内容'
    assert_text        '説明を更新'
    assert_selector    'img[src$="/syokki_mug_cup.png"]'
  end

  test '作業記録の画像の並び順を変更する' do
    visit studio_my_piece_path(@studio, @piece)

    within 'div.kml-log', text: '2026-04-05' do
      click_on 'この記録を編集'
    end

    source = find('.kml-sortable__row:nth-child(1) .kml-sortable__handle')
    target = find('.kml-sortable__row:nth-child(2)')

    source.drag_to target

    within '.kml-sortable__row:nth-child(1)' do
      assert_selector 'img[src$="/dish.png"]'
    end

    within '.kml-sortable__row:nth-child(2)' do
      assert_selector 'img[src$="/dish_cup.png"]'
    end

    within 'footer' do
      click_on '更新する'
    end

    assert_text '作業記録を更新しました。'

    within '.kml-log', text: '2026-04-05' do
      within '.kml-log__photos li:nth-child(1)' do
        assert_selector 'img[src$="/dish.png"]'
      end

      within '.kml-log__photos li:nth-child(2)' do
        assert_selector 'img[src$="/dish_cup.png"]'
      end
    end
  end
end

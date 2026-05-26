require 'application_system_test_case'

class PiecesJsTest < ApplicationSystemTestCase
  driven_by_selenium

  setup do
    sign_in_as users(:alice)
  end

  test '作品を登録する' do
    visit my_pieces_path

    click_on '作品を登録'

    fill_in 'タイトル', with: 'お茶碗'
    choose '製作中'
    select '電動ろくろ', from: '成形方法'

    within '[data-nested-form-target="item"]' do
      assert_selector 'button[disabled]', text: '削除'

      select '白土',    from: '土'
      fill_in '使用量', with: '500'
    end

    click_on '釉薬を追加する'

    select '白マット', from: '釉薬'

    fill_in '作品説明', with: '自分用のお茶碗を作った'

    attach_file file_fixture('dish.png'), make_visible: true

    click_on '登録する'

    assert_text '製作中の作品を登録しました。'
    assert_text 'お茶碗'
    assert_text '製作中'
    assert_text '電動ろくろ'
    assert_text '白土 500g'
    assert_text '白マット'
    assert_text '自分用のお茶碗を作った'
    assert_selector 'img[src$="/dish.png"]'
  end

  test '作品を更新する' do
    visit my_piece_path(pieces(:cup))

    click_on '編集'

    fill_in 'タイトル', with: '大きいマグカップ'

    click_on '土を追加する'

    within '.clays :nth-last-child(1 of [data-nested-form-target="item"])' do
      select '黒土',    from: '土'
      fill_in '使用量', with: '100'
    end

    click_on '釉薬を追加する'

    within '.glazes :nth-last-child(1 of [data-nested-form-target="item"])' do
      select '黒マット', from: '釉薬'
    end

    click_on '更新する'

    assert_text '製作中の作品を更新しました。'
    assert_text '大きいマグカップ'
    assert_text '白土 500g'
    assert_text '黒土 100g'
    assert_text '白マット'
    assert_text '黒マット'
  end

  test '作品から土と釉薬を削除する' do
    visit my_piece_path(pieces(:base))

    click_on '編集'

    within '.clays :nth-last-child(1 of [data-nested-form-target="item"])' do
      click_on '削除'
    end

    within '.glazes :nth-last-child(1 of [data-nested-form-target="item"])' do
      click_on '削除'
    end

    click_on '更新する'

    assert_text '製作中の作品を更新しました。'
    assert_text '白土'
    assert_no_text '黒土'
    assert_text '白マット'
    assert_no_text '黒マット'
  end
end

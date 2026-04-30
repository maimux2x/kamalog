require 'application_system_test_case'

class PiecesTest < ApplicationSystemTestCase
  setup do
    sign_in_as users(:alice)
  end

  test '作品を登録する' do
    visit my_in_progress_index_path

    click_on '制作する作品を登録'

    fill_in 'タイトル', with: 'お茶碗'
    choose '電動ろくろ'

    within '[data-nested-form-target="item"]' do
      assert_selector 'button[disabled]', text: '削除'

      select '白土',      from: '土'
      fill_in '使用量',   with: '500'
    end

    click_on '釉薬を追加する'

    select '白マット', from: '釉薬'

    click_on '登録する'

    assert_text '製作中の作品を登録しました。'
    assert_text '白土 500g'
    assert_text '白マット'
  end

  test '作品のタイトルを更新する' do
    visit my_piece_path(pieces(:cup))

    click_on '編集'

    assert_field 'タイトル', with: 'マグカップ'
    assert_checked_field '紐作り'
    assert_select '土',    selected: '白土'
    assert_select '釉薬',   selected: '白マット'

    fill_in 'タイトル', with: '大きいマグカップ'

    click_on '更新する'

    assert_text '製作中の作品を更新しました。'
    assert_text '大きいマグカップ'
  end
  test '作品に土と釉薬を追加する' do
    visit my_piece_path(pieces(:cup))

    click_on '編集'

    click_on '土を追加する'

    within '.clays [data-nested-form-target="item"]:last-of-type' do
      select '黒土',    from: '土'
      fill_in '使用量', with: '100'
    end

    click_on '釉薬を追加する'

    within '.glazes [data-nested-form-target="item"]:last-of-type' do
      select '黒マット', from: '釉薬'
    end

    click_on '更新する'

    assert_text '製作中の作品を更新しました。'
    assert_text '白土 500g'
    assert_text '黒土 100g'
    assert_text '白マット'
    assert_text '黒マット'
  end

  test '作品から土と釉薬を削除する' do
    visit my_piece_path(pieces(:base))

    click_on '編集'

    within '.clays [data-nested-form-target="item"]:last-of-type' do
      click_on '削除'
    end

    within '.glazes [data-nested-form-target="item"]:last-of-type' do
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

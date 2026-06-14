require 'application_system_test_case'

class My::PiecesTest < ApplicationSystemTestCase
  setup do
    sign_in_as users(:alice)

    @studio = users(:alice).studios.first
    @piece  = pieces(:cup)
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

  test '製作中の作品を登録する' do
    visit studio_my_pieces_path(@studio)

    click_on '作品を登録'

    fill_in 'タイトル', with: 'お茶碗'
    choose '製作中'
    select '電動ろくろ', from: '成形方法'

    within '[data-nested-form-target="item"]' do
      assert_selector 'button[disabled]', text: '削除'

      select '白土',    from: '土'
      fill_in '使用量', with: '500'
    end

    click_on '釉薬を追加'

    select '白マット', from: '釉薬'

    assert_no_text '作品説明'
    assert_no_text '画像を追加'

    click_on '登録する'

    assert_text '製作中の作品を登録しました。'
    assert_text 'お茶碗'
    assert_text '製作中'
    assert_text '電動ろくろ'
    assert_text '白土 500g'
    assert_text '白マット'
  end

  test '作品から土と釉薬を削除する' do
    visit studio_my_piece_path(@studio, pieces(:base))

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

  test '作品を削除する' do
    visit studio_my_piece_path(@studio, @piece)

    click_on '削除'

    assert_text '製作中の作品を削除しました。'
    assert_no_link 'マグカップ'
    assert_link '花瓶'
  end
end
